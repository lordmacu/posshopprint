package io.posjava;

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;


import android.content.BroadcastReceiver;
import android.widget.Toast;
import android.os.Message;

import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import android.os.Bundle;
import android.util.Log;
import com.iposprinter.iposprinterservice.*;
import android.os.RemoteException;

import com.iposprinter.printertestdemo.Utils.ButtonDelayUtils;
import com.iposprinter.printertestdemo.Utils.BytesUtil;
import com.iposprinter.printertestdemo.Utils.HandlerUtils;
import static com.iposprinter.printertestdemo.Utils.PrintContentsExamples.customCHR;
import static com.iposprinter.printertestdemo.Utils.PrintContentsExamples.customCHZ1;
import static com.iposprinter.printertestdemo.Utils.PrintContentsExamples.Text;
import static com.iposprinter.printertestdemo.Utils.PrintContentsExamples.Elemo;
import static com.iposprinter.printertestdemo.Utils.PrintContentsExamples.Baidu;
import static com.iposprinter.printertestdemo.MemInfo.bitmapRecycle;


import  com.iposprinter.printertestdemo.ThreadPoolManager;

import android.content.BroadcastReceiver;
import android.content.IntentFilter;
 import android.os.Bundle;
import java.util.Random;

import android.view.WindowManager;
import com.iposprinter.iposprinterservice.*;
import android.app.Activity;
import android.app.AlertDialog;
import android.content.ComponentName;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.ServiceConnection;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.IBinder;
import android.os.Message;
import android.os.RemoteException;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;


public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "samples.flutter.dev/battery";
    private static final String TAG                 = "IPosPrinterTestDemo";
    private IPosPrinterService mIPosPrinterService;
    private IPosPrinterCallback callback = null;


    /*定义打印机状态*/
    private final int PRINTER_NORMAL = 0;
    private final int PRINTER_PAPERLESS = 1;
    private final int PRINTER_THP_HIGH_TEMPERATURE = 2;
    private final int PRINTER_MOTOR_HIGH_TEMPERATURE = 3;
    private final int PRINTER_IS_BUSY = 4;
    private final int PRINTER_ERROR_UNKNOWN = 5;
    /*打印机当前状态*/
    private int printerStatus = 0;

    /*定义状态广播*/
    private final String  PRINTER_NORMAL_ACTION = "com.iposprinter.iposprinterservice.NORMAL_ACTION";
    private final String  PRINTER_PAPERLESS_ACTION = "com.iposprinter.iposprinterservice.PAPERLESS_ACTION";
    private final String  PRINTER_PAPEREXISTS_ACTION = "com.iposprinter.iposprinterservice.PAPEREXISTS_ACTION";
    private final String  PRINTER_THP_HIGHTEMP_ACTION = "com.iposprinter.iposprinterservice.THP_HIGHTEMP_ACTION";
    private final String  PRINTER_THP_NORMALTEMP_ACTION = "com.iposprinter.iposprinterservice.THP_NORMALTEMP_ACTION";
    private final String  PRINTER_MOTOR_HIGHTEMP_ACTION = "com.iposprinter.iposprinterservice.MOTOR_HIGHTEMP_ACTION";
    private final String  PRINTER_BUSY_ACTION = "com.iposprinter.iposprinterservice.BUSY_ACTION";
    private final String  PRINTER_CURRENT_TASK_PRINT_COMPLETE_ACTION = "com.iposprinter.iposprinterservice.CURRENT_TASK_PRINT_COMPLETE_ACTION";

    /*定义消息*/
    private final int MSG_TEST                               = 1;
    private final int MSG_IS_NORMAL                          = 2;
    private final int MSG_IS_BUSY                            = 3;
    private final int MSG_PAPER_LESS                         = 4;
    private final int MSG_PAPER_EXISTS                       = 5;
    private final int MSG_THP_HIGH_TEMP                      = 6;
    private final int MSG_THP_TEMP_NORMAL                    = 7;
    private final int MSG_MOTOR_HIGH_TEMP                    = 8;
    private final int MSG_MOTOR_HIGH_TEMP_INIT_PRINTER       = 9;
    private final int MSG_CURRENT_TASK_PRINT_COMPLETE     = 10;

    /*循环打印类型*/
    private final int  MULTI_THREAD_LOOP_PRINT  = 1;
    private final int  INPUT_CONTENT_LOOP_PRINT = 2;
    private final int  DEMO_LOOP_PRINT          = 3;
    private final int  PRINT_DRIVER_ERROR_TEST  = 4;
    private final int  DEFAULT_LOOP_PRINT       = 0;

    //循环打印标志位
    private       int  loopPrintFlag            = DEFAULT_LOOP_PRINT;
    private       byte loopContent              = 0x00;
    private       int  printDriverTestCount     = 0;

    private HandlerUtils.MyHandler handler;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Log.i(TAG,"aquiii cargando el oncreate");


    }
    public int getPrinterStatus(){

        Log.i(TAG,"***** printerStatus"+printerStatus);
        try{
            printerStatus = mIPosPrinterService.getPrinterStatus();
        }catch (RemoteException e){
            e.printStackTrace();
        }
        Log.i(TAG,"#### printerStatus"+printerStatus);
        return  printerStatus;
    }



    private HandlerUtils.IHandlerIntent iHandlerIntent = new HandlerUtils.IHandlerIntent()
    {
        @Override
        public void handlerIntent(Message msg)
        {
            switch (msg.what)
            {
                case MSG_TEST:
                    break;
                case MSG_IS_NORMAL:
                    if(getPrinterStatus() == PRINTER_NORMAL)
                    {
                      //  loopPrint(loopPrintFlag);
                    }
                    break;
                case MSG_IS_BUSY:
                    Toast.makeText(MainActivity.this, "printer_is_working", Toast.LENGTH_SHORT).show();
                    break;
                case MSG_PAPER_LESS:
                    loopPrintFlag = DEFAULT_LOOP_PRINT;
                    Toast.makeText(MainActivity.this, "out_of_paper", Toast.LENGTH_SHORT).show();
                    break;
                case MSG_PAPER_EXISTS:
                    Toast.makeText(MainActivity.this, "exists_paperr", Toast.LENGTH_SHORT).show();
                    break;
                case MSG_THP_HIGH_TEMP:
                    Toast.makeText(MainActivity.this, "printer_high_temp_alarm", Toast.LENGTH_SHORT).show();
                    break;
                case MSG_MOTOR_HIGH_TEMP:
                    loopPrintFlag = DEFAULT_LOOP_PRINT;
                    Toast.makeText(MainActivity.this, "motor_high_temp_alarm", Toast.LENGTH_SHORT).show();
                    handler.sendEmptyMessageDelayed(MSG_MOTOR_HIGH_TEMP_INIT_PRINTER, 180000);  //马达高温报警，等待3分钟后复位打印机
                    break;
                case MSG_MOTOR_HIGH_TEMP_INIT_PRINTER:
                    printerInit();
                    break;
                case MSG_CURRENT_TASK_PRINT_COMPLETE:
                    Toast.makeText(MainActivity.this, "printer_current_task_print_complete", Toast.LENGTH_SHORT).show();
                    break;
                default:
                    break;
            }
        }
    };

    public void printerInit(){
        ThreadPoolManager.getInstance().executeTask(new Runnable() {
            @Override
            public void run() {
                try{
                    mIPosPrinterService.printerInit(callback);
                }catch (RemoteException e){
                    e.printStackTrace();
                }
            }
        });
    }

    public void preinit(){
        Log.i(TAG,"antes:");

        handler = new HandlerUtils.MyHandler(iHandlerIntent);

        Log.i(TAG,"uno:" );

        Intent intent=new Intent();
        intent.setPackage("com.iposprinter.iposprinterservice");
        intent.setAction("com.iposprinter.iposprinterservice.IPosPrintService");
        bindService(intent, connectService, Context.BIND_AUTO_CREATE);
        Log.i(TAG,"dos:");


        IntentFilter printerStatusFilter = new IntentFilter();
        printerStatusFilter.addAction(PRINTER_NORMAL_ACTION);
        printerStatusFilter.addAction(PRINTER_PAPERLESS_ACTION);
        printerStatusFilter.addAction(PRINTER_PAPEREXISTS_ACTION);
        printerStatusFilter.addAction(PRINTER_THP_HIGHTEMP_ACTION);
        printerStatusFilter.addAction(PRINTER_THP_NORMALTEMP_ACTION);
        printerStatusFilter.addAction(PRINTER_MOTOR_HIGHTEMP_ACTION);
        printerStatusFilter.addAction(PRINTER_BUSY_ACTION);

        registerReceiver(IPosPrinterStatusListener,printerStatusFilter);
    }

    public void reinit(){
        callback = new IPosPrinterCallback.Stub() {

            @Override
            public void onRunResult(final boolean isSuccess) throws RemoteException {
                Log.i(TAG,"resultlllllllllll:" + isSuccess + "\n");
            }

            @Override
            public void onReturnString(final String value) throws RemoteException {
                Log.i(TAG,"resultrrrrrrrrrrrr:" + value + "\n");
            }
        };
    }



    private BroadcastReceiver IPosPrinterStatusListener = new BroadcastReceiver(){
        @Override
        public void onReceive(Context context, Intent intent){
            String action = intent.getAction();
            if(action == null)
            {
                Log.d(TAG,"IPosPrinterStatusListener onReceive action = null");
                return;
            }
            Log.d(TAG,"IPosPrinterStatusListener action = "+action);
            if(action.equals(PRINTER_NORMAL_ACTION))
            {
                handler.sendEmptyMessageDelayed(MSG_IS_NORMAL,0);
            }
            else if (action.equals(PRINTER_PAPERLESS_ACTION))
            {
                handler.sendEmptyMessageDelayed(MSG_PAPER_LESS,0);
            }
            else if (action.equals(PRINTER_BUSY_ACTION))
            {
                handler.sendEmptyMessageDelayed(MSG_IS_BUSY,0);
            }
            else if (action.equals(PRINTER_PAPEREXISTS_ACTION))
            {
                handler.sendEmptyMessageDelayed(MSG_PAPER_EXISTS,0);
            }
            else if (action.equals(PRINTER_THP_HIGHTEMP_ACTION))
            {
                handler.sendEmptyMessageDelayed(MSG_THP_HIGH_TEMP,0);
            }
            else if (action.equals(PRINTER_THP_NORMALTEMP_ACTION))
            {
                handler.sendEmptyMessageDelayed(MSG_THP_TEMP_NORMAL,0);
            }
            else if (action.equals(PRINTER_MOTOR_HIGHTEMP_ACTION))  //此时当前任务会继续打印，完成当前任务后，请等待2分钟以上时间，继续下一个打印任务
            {
                handler.sendEmptyMessageDelayed(MSG_MOTOR_HIGH_TEMP,0);
            }
            else if(action.equals(PRINTER_CURRENT_TASK_PRINT_COMPLETE_ACTION))
            {
                handler.sendEmptyMessageDelayed(MSG_CURRENT_TASK_PRINT_COMPLETE,0);
            }
            else
            {
                handler.sendEmptyMessageDelayed(MSG_TEST,0);
            }
        }
    };

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {




                            if (call.method.equals("getBatteryLevel")) {
                                Log.i(TAG,"aqui espichando");

                                preinit();


                            }else if (call.method.equals("printerinit")) {

                            } else {
                                result.notImplemented();
                            }


                        }
                );
    }

    private int getBatteryLevel() {
        int batteryLevel = -1;
        if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
            BatteryManager batteryManager = (BatteryManager) getSystemService(BATTERY_SERVICE);
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
        } else {
            Intent intent = new ContextWrapper(getApplicationContext()).
                    registerReceiver(null, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
            batteryLevel = (intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100) /
                    intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
        }

        return batteryLevel;
    }

    private ServiceConnection connectService = new ServiceConnection() {


        @Override
        public void onServiceConnected(ComponentName name, IBinder service) {
            mIPosPrinterService = IPosPrinterService.Stub.asInterface(service);
            Log.i(TAG,"cnecteddfasdfasdfa ");

            reinit();

            fullTest();

        }

        @Override
        public void onServiceDisconnected(ComponentName name) {
            mIPosPrinterService = null;
            Log.i(TAG,"discnecteddfasdfasdfa ");

        }
    };

    public void fullTest()
    {
        ThreadPoolManager.getInstance().executeTask(new Runnable() {
            @Override
            public void run() {
                Bitmap bmp;
                try{

                    mIPosPrinterService.printRawData(BytesUtil.initBlackBlock(384), callback);
                    mIPosPrinterService.printBlankLines(1, 10, callback);
                    mIPosPrinterService.printRawData(BytesUtil.initBlackBlock(48,384), callback);
                    mIPosPrinterService.printBlankLines(1, 10, callback);
                    mIPosPrinterService.printRawData(BytesUtil.initGrayBlock(48,384), callback);
                    mIPosPrinterService.printBlankLines(1, 10, callback);
                    mIPosPrinterService.setPrinterPrintAlignment(0,callback);
                    mIPosPrinterService.setPrinterPrintFontSize(24,callback);
                    String[] text = new String[4];
                    int[] width = new int[] { 10, 6, 6, 8 };
                    int[] align = new int[] { 0, 2, 2, 2 }; // 左齐,右齐,右齐,右齐
                    text[0] = "名称";
                    text[1] = "数量";
                    text[2] = "单价";
                    text[3] = "金额";
                    mIPosPrinterService.printColumnsText(text, width, align, 1,callback);
                    text[0] = "草莓酸奶A布甸";
                    text[1] = "4";
                    text[2] = "12.00";
                    text[3] = "48.00";
                    mIPosPrinterService.printColumnsText(text, width, align, 1,callback);
                    text[0] = "酸奶水果夹心面包B";
                    text[1] = "10";
                    text[2] = "4.00";
                    text[3] = "40.00";
                    mIPosPrinterService.printColumnsText(text, width, align, 1,callback);
                    text[0] = "酸奶水果布甸香橙软桃蛋糕"; // 文字超长,换行
                    text[1] = "100";
                    text[2] = "16.00";
                    text[3] = "1600.00";
                    mIPosPrinterService.printColumnsText(text, width, align, 1,callback);
                    text[0] = "酸奶水果夹心面包";
                    text[1] = "10";
                    text[2] = "4.00";
                    text[3] = "40.00";
                    mIPosPrinterService.printColumnsText(text, width, align, 0,callback);
                    mIPosPrinterService.printBlankLines(1, 16, callback);

                    mIPosPrinterService.setPrinterPrintAlignment(1,callback);
                    mIPosPrinterService.setPrinterPrintFontSize(24,callback);
                    text = new String[3];
                    width = new int[] { 10, 6, 8 };
                    align = new int[] { 0, 2, 2 };
                    text[0] = "菜品";
                    text[1] = "数量";
                    text[2] = "金额";
                    mIPosPrinterService.printColumnsText(text, width, align, 1,callback);
                    text[0] = "草莓酸奶布甸";
                    text[1] = "4";
                    text[2] = "48.00";
                    mIPosPrinterService.printColumnsText(text, width, align, 1,callback);
                    text[0] = "酸奶水果夹心面包B";
                    text[1] = "10";
                    text[2] = "40.00";
                    mIPosPrinterService.printColumnsText(text, width, align, 1,callback);
                    text[0] = "酸奶水果布甸香橙软桃蛋糕"; // 文字超长,换行
                    text[1] = "100";
                    text[2] = "1600.00";
                    mIPosPrinterService.printColumnsText(text, width, align, 1,callback);
                    text[0] = "酸奶水果夹心面包";
                    text[1] = "10";
                    text[2] = "40.00";
                    mIPosPrinterService.printColumnsText(text, width, align, 0,callback);
                    mIPosPrinterService.printBlankLines(1, 16, callback);

                    mIPosPrinterService.setPrinterPrintAlignment(2,callback);
                    mIPosPrinterService.setPrinterPrintFontSize(16,callback);
                    text = new String[4];
                    width = new int[] { 10, 6, 6, 8 };
                    align = new int[] { 0, 2, 2, 2 }; // 左齐,右齐,右齐,右齐
                    text[0] = "名称";
                    text[1] = "数量";
                    text[2] = "单价";
                    text[3] = "金额";
                    mIPosPrinterService.printColumnsText(text, width, align, 1,callback);
                    text[0] = "草莓酸奶A布甸";
                    text[1] = "4";
                    text[2] = "12.00";
                    text[3] = "48.00";
                    mIPosPrinterService.printColumnsText(text, width, align, 1,callback);
                    text[0] = "酸奶水果夹心面包B";
                    text[1] = "10";
                    text[2] = "4.00";
                    text[3] = "40.00";
                    mIPosPrinterService.printColumnsText(text, width, align, 1,callback);
                    text[0] = "酸奶水果布甸香橙软桃蛋糕"; // 文字超长,换行
                    text[1] = "100";
                    text[2] = "16.00";
                    text[3] = "1600.00";
                    mIPosPrinterService.printColumnsText(text, width, align, 1,callback);
                    text[0] = "酸奶水果夹心面包";
                    text[1] = "10";
                    text[2] = "4.00";
                    text[3] = "40.00";
                    mIPosPrinterService.printColumnsText(text, width, align, 0,callback);
                    mIPosPrinterService.printBlankLines(1, 10, callback);

                   /* bmp = BitmapFactory.decodeResource(getResources(), R.mipmap.test_p);
                    mIPosPrinterService.printBitmap(0, 12, bmp, callback);
                    mIPosPrinterService.printBitmap(1, 6, bmp, callback);
                    mIPosPrinterService.printBitmap(2, 16, bmp, callback);
                    mIPosPrinterService.printBlankLines(1, 10, callback);*/

                    mIPosPrinterService.printSpecifiedTypeText("智能POS\n" +
                            "智能POS智能POS\n" +
                            "智能POS智能POS智能POS\n" +
                            "智能POS智能POS智能POS智能POS\n" +
                            "智能POS智能POS智能POS智能POS智能POS\n" +
                            "智能POS智能POS智能POS智能POS智能POS智能POS\n" +
                            "智能POS智能POS智能POS智能POS智能POS智能POS智能\n" +
                            "智能POS智能POS智能POS智能POS智能POS智能POS智能\n" +
                            "智能POS智能POS智能POS智能POS智能POS智能POS智能\n" +
                            "智能POS智能POS智能POS智能POS智能POS智能POS\n" +
                            "智能POS智能POS智能POS智能POS智能POS\n" +
                            "智能POS智能POS智能POS智能POS\n" +
                            "智能POS智能POS智能POS\n" +
                            "智能POS智能POS\n" +
                            "智能POS\n", "ST", 16, callback);
                    mIPosPrinterService.printBlankLines(1, 10, callback);
                    mIPosPrinterService.printSpecifiedTypeText("智能POS\n" +
                            "智能POS智能POS\n" +
                            "智能POS智能POS智能POS\n" +
                            "智能POS智能POS智能POS智能POS\n" +
                            "智能POS智能POS智能POS智能POS智能\n" +
                            "智能POS智能POS智能POS智能POS\n" +
                            "智能POS智能POS智能POS\n" +
                            "智能POS智能POS\n" +
                            "智能POS\n", "ST", 24, callback);
                    mIPosPrinterService.printBlankLines(1, 10, callback);
                    mIPosPrinterService.printSpecifiedTypeText("手\n" +
                            "手手\n" +
                            "手手手\n" +
                            "手手手手\n" +
                            "手手手手手\n" +
                            "手手手手手手\n" +
                            "手手手手手手手\n" +
                            "手手手手手手手手\n" +
                            "手手手手手手手手手\n" +
                            "手手手手手手手手手手\n" +
                            "手手手手手手手手手手手\n" +
                            "手手手手手手手手手手手手" +
                            "手手手手手手手手手手手\n" +
                            "手手手手手手手手手手\n" +
                            "手手手手手手手手手\n" +
                            "手手手手手手手手\n" +
                            "手手手手手手手\n" +
                            "手手手手手手\n" +
                            "手手手手手\n" +
                            "手手手手\n" +
                            "手手手\n" +
                            "手手\n" +
                            "手\n", "ST", 32, callback);
                    mIPosPrinterService.printBlankLines(1, 10, callback);
                    mIPosPrinterService.printSpecifiedTypeText("手\n" +
                            "手手\n" +
                            "手手手\n" +
                            "手手手手\n" +
                            "手手手手手\n" +
                            "手手手手手手\n" +
                            "手手手手手手手\n" +
                            "手手手手手手手手" +
                            "手手手手手手手\n" +
                            "手手手手手手\n" +
                            "手手手手手\n" +
                            "手手手手\n" +
                            "手手手\n" +
                            "手手\n" +
                            "手\n", "ST", 48, callback);
                    mIPosPrinterService.printBlankLines(1, 10, callback);
                    int k = 8;
                    for (int i = 0; i < 48; i++)
                    {
                        bmp = BytesUtil.getLineBitmapFromData(12, k);
                        k += 8;
                        if (null != bmp)
                        {
                            mIPosPrinterService.printBitmap(1, 11, bmp, callback);
                        }
                    }
                    mIPosPrinterService.printBlankLines(1, 10, callback);
                    /*加快bitmap回收，减少内存占用*/
                 //   bitmapRecycle(bmp);
                    mIPosPrinterService.printerPerformPrint(160,  callback);
                }catch (RemoteException e){
                    e.printStackTrace();
                }
            }
        });
    }
}