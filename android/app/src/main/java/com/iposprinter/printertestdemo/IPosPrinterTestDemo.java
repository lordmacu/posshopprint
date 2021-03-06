package com.iposprinter.printertestdemo;

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

import com.iposprinter.printertestdemo.Utils.ButtonDelayUtils;
import com.iposprinter.printertestdemo.Utils.BytesUtil;
import com.iposprinter.printertestdemo.Utils.HandlerUtils;
import static com.iposprinter.printertestdemo.Utils.PrintContentsExamples.customCHR;
import static com.iposprinter.printertestdemo.Utils.PrintContentsExamples.customCHZ1;
import static com.iposprinter.printertestdemo.Utils.PrintContentsExamples.Text;
import static com.iposprinter.printertestdemo.Utils.PrintContentsExamples.Elemo;
import static com.iposprinter.printertestdemo.Utils.PrintContentsExamples.Baidu;
import static com.iposprinter.printertestdemo.MemInfo.bitmapRecycle;
public class IPosPrinterTestDemo  {

    private static final String TAG                 = "IPosPrinterTestDemo";
     private static final String VERSION        = "V1.1.0";


    private Button b_barcode, b_pic, b_qcode, b_self, b_text, b_table, b_init, b_lines, b_test, b_testall;
    private Button b_erlmo, b_meituan, b_baidu, b_query, b_bytes, b_length, b_continu,b_koubei;
    private Button b_runpaper, b_motor, b_demo, b_wave, b_error, b_loop;

     private final int PRINTER_NORMAL = 0;
    private final int PRINTER_PAPERLESS = 1;
    private final int PRINTER_THP_HIGH_TEMPERATURE = 2;
    private final int PRINTER_MOTOR_HIGH_TEMPERATURE = 3;
    private final int PRINTER_IS_BUSY = 4;
    private final int PRINTER_ERROR_UNKNOWN = 5;
     private int printerStatus = 0;

     private final String  PRINTER_NORMAL_ACTION = "com.iposprinter.iposprinterservice.NORMAL_ACTION";
    private final String  PRINTER_PAPERLESS_ACTION = "com.iposprinter.iposprinterservice.PAPERLESS_ACTION";
    private final String  PRINTER_PAPEREXISTS_ACTION = "com.iposprinter.iposprinterservice.PAPEREXISTS_ACTION";
    private final String  PRINTER_THP_HIGHTEMP_ACTION = "com.iposprinter.iposprinterservice.THP_HIGHTEMP_ACTION";
    private final String  PRINTER_THP_NORMALTEMP_ACTION = "com.iposprinter.iposprinterservice.THP_NORMALTEMP_ACTION";
    private final String  PRINTER_MOTOR_HIGHTEMP_ACTION = "com.iposprinter.iposprinterservice.MOTOR_HIGHTEMP_ACTION";
    private final String  PRINTER_BUSY_ACTION = "com.iposprinter.iposprinterservice.BUSY_ACTION";
    private final String  PRINTER_CURRENT_TASK_PRINT_COMPLETE_ACTION = "com.iposprinter.iposprinterservice.CURRENT_TASK_PRINT_COMPLETE_ACTION";

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

     private final int  MULTI_THREAD_LOOP_PRINT  = 1;
    private final int  INPUT_CONTENT_LOOP_PRINT = 2;
    private final int  DEMO_LOOP_PRINT          = 3;
    private final int  PRINT_DRIVER_ERROR_TEST  = 4;
    private final int  DEFAULT_LOOP_PRINT       = 0;

     private       int  loopPrintFlag            = DEFAULT_LOOP_PRINT;
    private       byte loopContent              = 0x00;
    private       int  printDriverTestCount     = 0;


    private TextView info;
    private IPosPrinterService mIPosPrinterService;
    private IPosPrinterCallback callback = null;

    private Random random = new Random();
    private HandlerUtils.MyHandler handler;

    private void setButtonEnable(boolean flag){
        b_barcode.setEnabled(flag);
        b_pic.setEnabled(flag);
        b_qcode.setEnabled(flag);
        b_self.setEnabled(flag);
        b_text.setEnabled(flag);
        b_table.setEnabled(flag);
        b_init.setEnabled(flag);
        b_lines.setEnabled(flag);
        b_test.setEnabled(flag);
        b_testall.setEnabled(flag);
        b_erlmo.setEnabled(flag);
        b_meituan.setEnabled(flag);
        b_bytes.setEnabled(flag);
        b_query.setEnabled(flag);
        b_baidu.setEnabled(flag);
        b_length.setEnabled(flag);
        b_continu.setEnabled(flag);
        b_koubei.setEnabled(flag);
        b_runpaper.setEnabled(flag);
        b_motor.setEnabled(flag);
        b_demo.setEnabled(flag);
        b_wave.setEnabled(flag);
        b_error.setEnabled(flag);
        b_loop.setEnabled(flag);
    }

    /**
     * ????????????
     */
    /*
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
                        loopPrint(loopPrintFlag);
                    }
                    break;
                case MSG_IS_BUSY:
                    Toast.makeText(IPosPrinterTestDemo.this, R.string.printer_is_working, Toast.LENGTH_SHORT).show();
                    break;
                case MSG_PAPER_LESS:
                    loopPrintFlag = DEFAULT_LOOP_PRINT;
                    Toast.makeText(IPosPrinterTestDemo.this, R.string.out_of_paper, Toast.LENGTH_SHORT).show();
                    break;
                case MSG_PAPER_EXISTS:
                    Toast.makeText(IPosPrinterTestDemo.this, R.string.exists_paper, Toast.LENGTH_SHORT).show();
                    break;
                case MSG_THP_HIGH_TEMP:
                    Toast.makeText(IPosPrinterTestDemo.this, R.string.printer_high_temp_alarm, Toast.LENGTH_SHORT).show();
                    break;
                case MSG_MOTOR_HIGH_TEMP:
                    loopPrintFlag = DEFAULT_LOOP_PRINT;
                    Toast.makeText(IPosPrinterTestDemo.this, R.string.motor_high_temp_alarm, Toast.LENGTH_SHORT).show();
                    handler.sendEmptyMessageDelayed(MSG_MOTOR_HIGH_TEMP_INIT_PRINTER, 180000);  //???????????????????????????3????????????????????????
                    break;
                case MSG_MOTOR_HIGH_TEMP_INIT_PRINTER:
                    printerInit();
                    break;
                case MSG_CURRENT_TASK_PRINT_COMPLETE:
                    Toast.makeText(IPosPrinterTestDemo.this, R.string.printer_current_task_print_complete, Toast.LENGTH_SHORT).show();
                    break;
                default:
                    break;
            }
        }
    };
*/
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
            else if (action.equals(PRINTER_MOTOR_HIGHTEMP_ACTION))  //?????????????????????????????????????????????????????????????????????2????????????????????????????????????????????????
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

    /**
     * ??????????????????
     */
    private ServiceConnection connectService = new ServiceConnection() {
        @Override
        public void onServiceConnected(ComponentName name, IBinder service) {
            mIPosPrinterService = IPosPrinterService.Stub.asInterface(service);
            setButtonEnable(true);
        }

        @Override
        public void onServiceDisconnected(ComponentName name) {
            mIPosPrinterService = null;
        }
    };

   /* @Override
    protected void onCreate(Bundle savedInstanceState) {
       // super.onCreate(savedInstanceState);
       // setContentView(R.layout.activity_ipos_printer_test_demo);
        //????????????????????????????????????????????????
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON, WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
       // handler = new HandlerUtils.MyHandler(iHandlerIntent);

        callback = new IPosPrinterCallback.Stub() {

            @Override
            public void onRunResult(final boolean isSuccess) throws RemoteException {
                Log.i(TAG,"result:" + isSuccess + "\n");
            }

            @Override
            public void onReturnString(final String value) throws RemoteException {
                Log.i(TAG,"result:" + value + "\n");
            }
        };

        //????????????
        Intent intent=new Intent();
        intent.setPackage("com.iposprinter.iposprinterservice");
        intent.setAction("com.iposprinter.iposprinterservice.IPosPrintService");
        //startService(intent);
        bindService(intent, connectService, Context.BIND_AUTO_CREATE);

        //??????????????????????????????
        IntentFilter printerStatusFilter = new IntentFilter();
        printerStatusFilter.addAction(PRINTER_NORMAL_ACTION);
        printerStatusFilter.addAction(PRINTER_PAPERLESS_ACTION);
        printerStatusFilter.addAction(PRINTER_PAPEREXISTS_ACTION);
        printerStatusFilter.addAction(PRINTER_THP_HIGHTEMP_ACTION);
        printerStatusFilter.addAction(PRINTER_THP_NORMALTEMP_ACTION);
        printerStatusFilter.addAction(PRINTER_MOTOR_HIGHTEMP_ACTION);
        printerStatusFilter.addAction(PRINTER_BUSY_ACTION);

        registerReceiver(IPosPrinterStatusListener,printerStatusFilter);
    }*/
/*
    @Override
    protected void onResume()
    {
        Log.d(TAG, "activity onResume");
        super.onResume();
    }

    @Override
    protected void onPause()
    {
        Log.d(TAG, "activity onPause");
        super.onPause();
    }

    @Override
    protected void onStop()
    {
        Log.e(TAG, "activity onStop");
        loopPrintFlag = DEFAULT_LOOP_PRINT;
        super.onStop();
    }

    @Override
    protected void onDestroy()
    {
        Log.d(TAG, "activity onDestroy");
        super.onDestroy();
       // unregisterReceiver(IPosPrinterStatusListener);
        //unbindService(connectService);
        handler.removeCallbacksAndMessages(null);
    }*/

 /*
    @Override
    public void onClick(View v){
        if (ButtonDelayUtils.isFastDoubleClick())
        {
            return;
        }
        switch (v.getId())
        {
            //??????????????????
            case R.id.b_length:
                if (getPrinterStatus() == PRINTER_NORMAL)
                    printRandomDot(500);
                break;
            //???????????????
            case R.id.b_block:
                if (getPrinterStatus() == PRINTER_NORMAL)
                    printBlackBlock(500);
                break;
            //?????????????????????????????????
            case R.id.b_testall:
                if (getPrinterStatus() == PRINTER_NORMAL)
                {
                    multiThreadLoopPrint();
                    loopPrintFlag = MULTI_THREAD_LOOP_PRINT;
                }
                break;
            //???????????????
            case R.id.b_erlmo:
                if (getPrinterStatus() == PRINTER_NORMAL)
                    printErlmoBill();
                break;
            //????????????
            case R.id.b_koubei:
                if (getPrinterStatus() == PRINTER_NORMAL)
                    printKoubeiBill();
                break;
            //????????????
            case R.id.b_meituan:
                if (getPrinterStatus() == PRINTER_NORMAL)
                    printMeiTuanBill();
                break;
            //????????????
            case R.id.b_baidu:
                if (getPrinterStatus() == PRINTER_NORMAL)
                    printBaiduBill();
                break;
            //??????????????????????????????
            case R.id.b_query:
                if (getPrinterStatus() == PRINTER_NORMAL)
                    queryPrintLength();
                break;
            //???????????????
            case R.id.b_self:
                if (getPrinterStatus() == PRINTER_NORMAL)
                    printSelf();
                break;
            //?????????????????????
            case R.id.b_lines:
                if (getPrinterStatus() == PRINTER_NORMAL)
                    printLineWrap(3, 24);
                break;
            //??????????????????
            case R.id.b_init:
                if (getPrinterStatus() == PRINTER_NORMAL)
                     printerInit();
                break;
            //????????????
            case R.id.b_text:
                if (getPrinterStatus() == PRINTER_NORMAL)
                    printText();
                break;
            //????????????
            case R.id.b_table:
                if (getPrinterStatus() == PRINTER_NORMAL)
                    printTable();
                break;
            //????????????
            case R.id.b_pic:
                if (getPrinterStatus() == PRINTER_NORMAL)
                    printBitmap();
                break;
            //???????????????
            case R.id.b_barcode:
                if (getPrinterStatus() == PRINTER_NORMAL)
                    printBarcode();
                break;
            //???????????????
            case R.id.b_qcode:
                if (getPrinterStatus() == PRINTER_NORMAL)
                    printQRCode();
                break;
            //????????????
            case R.id.b_test:
                if (getPrinterStatus() == PRINTER_NORMAL)
                    fullTest();
                break;
            //??????????????????
            case R.id.b_demo:
                if (getPrinterStatus() == PRINTER_NORMAL)
                {
                    loopPrintFlag = DEMO_LOOP_PRINT;
                    demoLoopPrint();
                }
                break;
            //????????????
            case R.id.b_exit:
                loopPrintFlag = DEFAULT_LOOP_PRINT;
                finish();
                break;
            //??????????????????
            case R.id.b_bytes:
                if (getPrinterStatus() == PRINTER_NORMAL)
                    inputBytes(1);
                break;
            case R.id.b_continu:
                if (getPrinterStatus() == PRINTER_NORMAL)
                    continuPrint();
                break;
            case R.id.b_error:
                if (getPrinterStatus() == PRINTER_NORMAL)
                {
                    loopPrintFlag = PRINT_DRIVER_ERROR_TEST;
                    printDriverTest();
                }
                break;
            case R.id.b_loop:
                if (getPrinterStatus() == PRINTER_NORMAL)
                    inputBytes(2);
                break;
            case R.id.b_wave:
                if (getPrinterStatus() == PRINTER_NORMAL)
                    wavePrintTest();
                break;
            case R.id.b_runpaper:
                if (getPrinterStatus() == PRINTER_NORMAL)
                    printerRunPaper(500);
                break;
            case R.id.b_motor:
                    printerInit();
                break;
            default:
                break;
        }
    }
*/
    /**
     * ?????????????????????
     */
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

    /**
     * ??????????????????
     */
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

    /**
     * ???????????????
     */
    public void printSelf()
    {
        ThreadPoolManager.getInstance().executeTask(new Runnable() {
            @Override
            public void run() {
                try {

                        mIPosPrinterService.printerInit(callback);

                        mIPosPrinterService.printSpecifiedTypeText("   ???????????????\n", "ST", 48, callback);
                        mIPosPrinterService.printBlankLines(1, 20, callback);
                        mIPosPrinterService.printRawData(BytesUtil.BlackBlockData(300),callback);
                        mIPosPrinterService.printBlankLines(1, 20, callback);
                        mIPosPrinterService.setPrinterPrintAlignment(1,callback);
                        mIPosPrinterService.printQRCode("http://www.baidu.com\n", 10, 1,callback);
                        mIPosPrinterService.printBlankLines(1, 20, callback);
                        mIPosPrinterService.printSpecifiedTypeText("   ???????????????\n", "ST", 48, callback);
                        mIPosPrinterService.printBlankLines(1, 16, callback);
                        mIPosPrinterService.printSpecifiedTypeText("        ????????????\n", "ST", 32, callback);
                        mIPosPrinterService.printerPerformPrint(160,  callback);

                }catch (RemoteException e)
                {
                    e.printStackTrace();
                }
            }
        });
    }

    /**
     * ??????????????????
     */
    public void queryPrintLength()
    {
        ThreadPoolManager.getInstance().executeTask(new Runnable() {
            @Override
            public void run() {
                try {
                    mIPosPrinterService.printSpecifiedTypeText("??????????????????\n????????????\n\n----------end-----------\n\n", "ST", 32, callback);
                    mIPosPrinterService.printerPerformPrint(160,  callback);
                }catch (RemoteException e)
                {
                    e.printStackTrace();
                }
            }
        });
    }

    /**
     * ???????????????
     */
    public void printerRunPaper(final int lines)
    {
        ThreadPoolManager.getInstance().executeTask(new Runnable() {
            @Override
            public void run() {
                try{
                    mIPosPrinterService.printerFeedLines(lines, callback);
                }catch (RemoteException e){
                    e.printStackTrace();
                }
            }
        });
    }

    /**
     * ???????????????
     */
    public void printLineWrap(final int lines, final int height)
    {
        ThreadPoolManager.getInstance().executeTask(new Runnable() {
            @Override
            public void run() {
                try{
                    mIPosPrinterService.printBlankLines(lines, height, callback);
                    mIPosPrinterService.printerPerformPrint(160,  callback);
                }catch (RemoteException e){
                    e.printStackTrace();
                }
            }
        });
    }

    /**
     * ??????????????????
     */
    public void printRandomDot(final int lines){
        ThreadPoolManager.getInstance().executeTask(new Runnable() {
            @Override
            public void run() {
                try{
                    mIPosPrinterService.printRawData(BytesUtil.RandomDotData(lines),callback);
                    mIPosPrinterService.printerPerformPrint(160,  callback);
                }catch (RemoteException e){
                    e.printStackTrace();
                }
            }
        });
    }

    /**
     * ???????????????
     */
    public void printBlackBlock(final int height)
    {
        ThreadPoolManager.getInstance().executeTask(new Runnable() {
            @Override
            public void run() {
                try{
                    mIPosPrinterService.printRawData(BytesUtil.BlackBlockData(height),callback);
                    mIPosPrinterService.printerPerformPrint(160,  callback);
                }catch (RemoteException e){
                    e.printStackTrace();
                }
            }
        });
    }
    /**
     * ????????????
     */
    public void printText()
    {
        ThreadPoolManager.getInstance().executeTask(new Runnable() {
            @Override
            public void run() {
                //Bitmap mBitmap = BitmapFactory.decodeResource(getResources(), R.mipmap.test);
                try {
                    mIPosPrinterService.printSpecifiedTypeText("    ??????POS???\n", "ST", 48, callback);
                    mIPosPrinterService.printSpecifiedTypeText("    ??????POS???????????????\n", "ST", 32, callback);
                    mIPosPrinterService.printBlankLines(1, 8, callback);
                    mIPosPrinterService.printSpecifiedTypeText("      ???????????????POS???????????????\n", "ST", 24, callback);
                    mIPosPrinterService.printBlankLines(1, 8, callback);
                    mIPosPrinterService.printSpecifiedTypeText("??????POS ???????????? ??????POS\n", "ST", 32, callback);
                    mIPosPrinterService.printBlankLines(1, 8, callback);
                    mIPosPrinterService.printSpecifiedTypeText("#POS POS ipos POS POS POS POS ipos POS POS ipos#\n", "ST", 16, callback);
                    mIPosPrinterService.printBlankLines(1, 16, callback);
                  //  mIPosPrinterService.printBitmap(1, 12, mBitmap, callback);
                    mIPosPrinterService.printBlankLines(1, 16, callback);
                    mIPosPrinterService.PrintSpecFormatText("??????????????????\n", "ST", 32, 1, callback);
                    mIPosPrinterService.printSpecifiedTypeText("********************************", "ST", 24, callback);
                    mIPosPrinterService.printSpecifiedTypeText("????????????16?????????\n", "ST", 16, callback);
                    mIPosPrinterService.printSpecifiedTypeText("????????????24?????????\n", "ST", 24, callback);
                    mIPosPrinterService.PrintSpecFormatText("????????????24?????????\n", "ST", 24, 2, callback);
                    mIPosPrinterService.printSpecifiedTypeText("????????????32?????????\n", "ST", 32, callback);
                    mIPosPrinterService.PrintSpecFormatText("????????????32?????????\n", "ST", 32, 2, callback);
                    mIPosPrinterService.printSpecifiedTypeText("????????????48?????????\n", "ST", 48, callback);
                    mIPosPrinterService.printSpecifiedTypeText("ABCDEFGHIJKLMNOPQRSTUVWXYZ01234\n", "ST", 16, callback);
                    mIPosPrinterService.printSpecifiedTypeText("abcdefghijklmnopqrstuvwxyz56789\n", "ST", 24, callback);
                    mIPosPrinterService.printSpecifiedTypeText("????????????????????????????????????\n", "ST", 24, callback);
                    mIPosPrinterService.setPrinterPrintAlignment(0,callback);
                    mIPosPrinterService.printQRCode("http://www.baidu.com\n", 10, 1, callback);
                    mIPosPrinterService.printBlankLines(1, 16, callback);
                    mIPosPrinterService.printBlankLines(1, 16, callback);
                    for (int i = 0; i < 12; i++)
                    {
                        mIPosPrinterService.printRawData(BytesUtil.initLine1(384, i),callback);
                    }
                    mIPosPrinterService.PrintSpecFormatText("??????????????????\n", "ST", 32, 1, callback);
                    mIPosPrinterService.printSpecifiedTypeText("**********END***********\n\n", "ST", 32, callback);
                  //  bitmapRecycle(mBitmap);
                    mIPosPrinterService.printerPerformPrint(160,  callback);
                }catch (RemoteException e){
                    e.printStackTrace();
                }
            }
        });
    }

    /**
     * ????????????
     */
    public void printTable()
    {
        ThreadPoolManager.getInstance().executeTask(new Runnable() {
            @Override
            public void run() {
                try{
                    mIPosPrinterService.setPrinterPrintAlignment(0,callback);
                    mIPosPrinterService.setPrinterPrintFontSize(24,callback);
                    String[] text = new String[4];
                    int[] width = new int[] { 8, 6, 6, 7 };
                    int[] align = new int[] { 0, 2, 2, 2 }; // ??????,??????,??????,??????
                    text[0] = "??????";
                    text[1] = "??????";
                    text[2] = "??????";
                    text[3] = "??????";
                    mIPosPrinterService.printColumnsText(text, width, align, 1,callback);
                    text[0] = "????????????A??????";
                    text[1] = "4";
                    text[2] = "12.00";
                    text[3] = "48.00";
                    mIPosPrinterService.printColumnsText(text, width, align, 1,callback);
                    text[0] = "????????????????????????B";
                    text[1] = "10";
                    text[2] = "4.00";
                    text[3] = "40.00";
                    mIPosPrinterService.printColumnsText(text, width, align, 1,callback);
                    text[0] = "????????????????????????????????????"; // ????????????,??????
                    text[1] = "100";
                    text[2] = "16.00";
                    text[3] = "1600.00";
                    mIPosPrinterService.printColumnsText(text, width, align, 1,callback);
                    text[0] = "????????????????????????";
                    text[1] = "10";
                    text[2] = "4.00";
                    text[3] = "40.00";
                    mIPosPrinterService.printColumnsText(text, width, align, 0,callback);
                    mIPosPrinterService.printBlankLines(1, 16, callback);

                    mIPosPrinterService.setPrinterPrintAlignment(1,callback);
                    mIPosPrinterService.setPrinterPrintFontSize(24,callback);
                    text = new String[3];
                    width = new int[] { 8, 6, 7 };
                    align = new int[] { 0, 2, 2 };
                    text[0] = "??????";
                    text[1] = "??????";
                    text[2] = "??????";
                    mIPosPrinterService.printColumnsText(text, width, align, 1,callback);
                    text[0] = "??????????????????";
                    text[1] = "4";
                    text[2] = "48.00";
                    mIPosPrinterService.printColumnsText(text, width, align, 1,callback);
                    text[0] = "????????????????????????B";
                    text[1] = "10";
                    text[2] = "40.00";
                    mIPosPrinterService.printColumnsText(text, width, align, 1,callback);
                    text[0] = "????????????????????????????????????"; // ????????????,??????
                    text[1] = "100";
                    text[2] = "1600.00";
                    mIPosPrinterService.printColumnsText(text, width, align, 1,callback);
                    text[0] = "????????????????????????";
                    text[1] = "10";
                    text[2] = "40.00";
                    mIPosPrinterService.printColumnsText(text, width, align, 0,callback);
                    mIPosPrinterService.printBlankLines(1, 16, callback);

                    mIPosPrinterService.setPrinterPrintAlignment(2,callback);
                    mIPosPrinterService.setPrinterPrintFontSize(16,callback);
                    text = new String[4];
                    width = new int[] { 10, 6, 6, 8 };
                    align = new int[] { 0, 2, 2, 2 }; // ??????,??????,??????,??????
                    text[0] = "??????";
                    text[1] = "??????";
                    text[2] = "??????";
                    text[3] = "??????";
                    mIPosPrinterService.printColumnsText(text, width, align, 1,callback);
                    text[0] = "????????????A??????";
                    text[1] = "4";
                    text[2] = "12.00";
                    text[3] = "48.00";
                    mIPosPrinterService.printColumnsText(text, width, align, 1,callback);
                    text[0] = "????????????????????????B";
                    text[1] = "10";
                    text[2] = "4.00";
                    text[3] = "40.00";
                    mIPosPrinterService.printColumnsText(text, width, align, 1,callback);
                    text[0] = "????????????????????????????????????"; // ????????????,??????
                    text[1] = "100";
                    text[2] = "16.00";
                    text[3] = "1600.00";
                    mIPosPrinterService.printColumnsText(text, width, align, 1,callback);
                    text[0] = "????????????????????????";
                    text[1] = "10";
                    text[2] = "4.00";
                    text[3] = "40.00";
                    mIPosPrinterService.printColumnsText(text, width, align, 0,callback);
                    mIPosPrinterService.printBlankLines(1, 8, callback);

                    mIPosPrinterService.printerPerformPrint(160,  callback);

                }catch (RemoteException e){
                    e.printStackTrace();
                }
            }
        });
    }

    /**
     * ????????????
     */
    public void printBitmap()
    {
       ThreadPoolManager.getInstance().executeTask(new Runnable() {
           @Override
           public void run() {
            //   Bitmap mBitmap = BitmapFactory.decodeResource(getResources(), R.mipmap.test_p);
               try{
                /*   mIPosPrinterService.printBitmap(0, 4, mBitmap, callback);
                   mIPosPrinterService.printBlankLines(1, 10, callback);

                   mIPosPrinterService.printBitmap(1, 6, mBitmap, callback);
                   mIPosPrinterService.printBlankLines(1, 10, callback);

                   mIPosPrinterService.printBitmap(2, 8, mBitmap, callback);
                   mIPosPrinterService.printBlankLines(1, 10, callback);

                   mIPosPrinterService.printBitmap(2, 10, mBitmap, callback);
                   mIPosPrinterService.printBlankLines(1, 10, callback);

                   mIPosPrinterService.printBitmap(1, 12, mBitmap, callback);
                   mIPosPrinterService.printBlankLines(1, 10, callback);

                   mIPosPrinterService.printBitmap(0, 14, mBitmap, callback);*/
                   mIPosPrinterService.printBlankLines(1, 10, callback);

                   mIPosPrinterService.printerPerformPrint(160,  callback);
               }catch (RemoteException e){
                   e.printStackTrace();
               }
           }
       });
    }

    /**
     * ???????????????
     */
    public void printBarcode()
    {
        ThreadPoolManager.getInstance().executeTask(new Runnable() {
            @Override
            public void run() {
                try{
                    mIPosPrinterService.setPrinterPrintAlignment(0,callback);
                    mIPosPrinterService.printBarCode("2017072618", 8, 2, 5, 0, callback);
                    mIPosPrinterService.printBlankLines(1, 25, callback);

                    mIPosPrinterService.setPrinterPrintAlignment(1,callback);
                    mIPosPrinterService.printBarCode("2017072618", 8, 3, 6, 1, callback);
                    mIPosPrinterService.printBlankLines(1, 25, callback);

                    mIPosPrinterService.setPrinterPrintAlignment(2,callback);
                    mIPosPrinterService.printBarCode("2017072618", 8, 4, 7, 2, callback);
                    mIPosPrinterService.printBlankLines(1, 25, callback);

                    mIPosPrinterService.setPrinterPrintAlignment(2,callback);
                    mIPosPrinterService.printBarCode("2017072618", 8, 5, 8, 3, callback);
                    mIPosPrinterService.printBlankLines(1, 25, callback);

                    mIPosPrinterService.setPrinterPrintAlignment(1,callback);
                    mIPosPrinterService.printBarCode("2017072618", 8, 3, 7, 3, callback);
                    mIPosPrinterService.printBlankLines(1, 25, callback);

                    mIPosPrinterService.setPrinterPrintAlignment(1,callback);
                    mIPosPrinterService.printBarCode("2017072618", 8, 3, 6, 1, callback);
                    mIPosPrinterService.printBlankLines(1, 25, callback);

                    mIPosPrinterService.setPrinterPrintAlignment(1,callback);
                    mIPosPrinterService.printBarCode("2017072618", 8, 3, 4, 2, callback);
                    mIPosPrinterService.printBlankLines(1, 25, callback);

                    mIPosPrinterService.printerPerformPrint(160,  callback);
                }catch (RemoteException e){
                    e.printStackTrace();
                }
            }
        });
    }

    /**
     * ???????????????
     */
    public void printQRCode()
    {
        ThreadPoolManager.getInstance().executeTask(new Runnable() {
            @Override
            public void run() {
                try {
                    mIPosPrinterService.setPrinterPrintAlignment(0, callback);
                    mIPosPrinterService.printQRCode("http://www.baidu.com\n", 2, 1, callback);
                    mIPosPrinterService.printBlankLines(1, 15, callback);

                    mIPosPrinterService.setPrinterPrintAlignment(1, callback);
                    mIPosPrinterService.printQRCode("http://www.baidu.com\n", 3, 0, callback);
                    mIPosPrinterService.printBlankLines(1, 15, callback);

                    mIPosPrinterService.setPrinterPrintAlignment(2, callback);
                    mIPosPrinterService.printQRCode("http://www.baidu.com\n", 4, 2, callback);
                    mIPosPrinterService.printBlankLines(1, 15, callback);

                    mIPosPrinterService.setPrinterPrintAlignment(0, callback);
                    mIPosPrinterService.printQRCode("http://www.baidu.com\n", 5, 3, callback);
                    mIPosPrinterService.printBlankLines(1, 15, callback);

                    mIPosPrinterService.setPrinterPrintAlignment(1, callback);
                    mIPosPrinterService.printQRCode("http://www.baidu.com\n", 6, 2, callback);
                    mIPosPrinterService.printBlankLines(1, 15, callback);

                    mIPosPrinterService.setPrinterPrintAlignment(2, callback);
                    mIPosPrinterService.printQRCode("http://www.baidu.com\n", 7, 1, callback);
                    mIPosPrinterService.printBlankLines(1, 15, callback);

                    mIPosPrinterService.printerPerformPrint(160,  callback);
                }catch (RemoteException e){
                    e.printStackTrace();
                }
            }
        });
    }

    /**
     * ?????????????????????
     */
    public void printErlmoBill()
    {
        ThreadPoolManager.getInstance().executeTask(new Runnable() {
            @Override
            public void run() {
                try {
                    mIPosPrinterService.printSpecifiedTypeText(Elemo, "ST", 32, callback);
                    mIPosPrinterService.printerPerformPrint(160,  callback);
                }catch (RemoteException e){
                    e.printStackTrace();
                }
            }
        });
    }

    /**
     * ???????????????
     */
    public void printBaiduBill()
    {
        ThreadPoolManager.getInstance().executeTask(new Runnable() {
            @Override
            public void run() {
                try {
                    mIPosPrinterService.printSpecifiedTypeText(Baidu, "ST", 32, callback);
                    mIPosPrinterService.printerPerformPrint(160,  callback);
                }catch (RemoteException e){
                    e.printStackTrace();
                }
            }
        });
    }

    /**
     * ????????????
     */
    public void printKoubeiBill()
    {
        ThreadPoolManager.getInstance().executeTask(new Runnable()
        {

            @Override
            public void run()
            {
                try {
                    mIPosPrinterService.printSpecifiedTypeText("   #4????????????\n", "ST", 48, callback);
                    mIPosPrinterService.printSpecifiedTypeText("         " + "?????????????????????\n********************************\n", "ST", 24, callback);
                    mIPosPrinterService.printSpecifiedTypeText("17:20 ????????????\n", "ST", 48, callback);
                    mIPosPrinterService.printSpecifiedTypeText("--------------------------------\n", "ST", 24, callback);
                    mIPosPrinterService.printSpecifiedTypeText("18610858337???????????????????????????7??????(605???)\n", "ST", 48, callback);
                    mIPosPrinterService.printSpecifiedTypeText("--------------------------------\n", "ST", 24, callback);
                    mIPosPrinterService.printSpecifiedTypeText("??????: 16:35\n", "ST", 48, callback);
                    mIPosPrinterService.printSpecifiedTypeText("********************************\n", "ST", 24, callback);
                    mIPosPrinterService.printSpecifiedTypeText("??????          ??????   ??????   " +
                            "??????\n--------------------------------\n??????????????? (???) (??????)\n" +
                            "               1      25      25\n??????????????? (???) (??????)\n               1      " +
                            "25      25??????????????? (???) (??????)\n               1      25      25\n--------------------------------\n?????????" +
                            "  " +
                            "               " +
                            "        2\n--------------------------------\n", "ST", 24, callback);
                    mIPosPrinterService.printSpecifiedTypeText("            ????????????: 27\n\n", "ST", 32, callback);
                    mIPosPrinterService.printSpecifiedTypeText("    ????????????\n\n\n", "ST", 48, callback);

                    mIPosPrinterService.printerPerformPrint(160,  callback);
                }catch (RemoteException e){
                    e.printStackTrace();
                }
            }
        });
    }

    /**
     * ????????????
     */
    public void printMeiTuanBill()
    {
        ThreadPoolManager.getInstance().executeTask(new Runnable()
        {

            @Override
            public void run()
            {
                try {
                    mIPosPrinterService.printSpecifiedTypeText("  #1  ????????????\n\n", "ST", 48, callback);
                    mIPosPrinterService.printSpecifiedTypeText("      ??????????????????(???1???)\n\n", "ST", 24, callback);
                    mIPosPrinterService.printSpecifiedTypeText("------------------------\n\n*********?????????*********\n", "ST", 32, callback);
                    mIPosPrinterService.printSpecifiedTypeText("  ??????????????????:[18:00]\n\n", "ST", 32, callback);
                    mIPosPrinterService.printSpecifiedTypeText("--------------------------------\n????????????: " + "01-01 12:00", "ST", 24, callback);
                    mIPosPrinterService.printSpecifiedTypeText("??????: ?????????\n", "ST", 32, callback);
                    mIPosPrinterService.printSpecifiedTypeText("??????          ??????   ??????"+"??????\n--------------------------------\n\n", "ST", 24, callback);
                    mIPosPrinterService.printSpecifiedTypeText("?????????          X1    12\n?????????1         X1   "+" 12\n?????????2         X1    12\n\n", "ST", 32, callback);
                    mIPosPrinterService.printSpecifiedTypeText("--------------------------------\n", "ST", 24, callback);
                    mIPosPrinterService.printSpecifiedTypeText("?????????                         5\n?????????        " +
                            " " +
                            " " +
                            "               1\n[????????????] - ????????????\n????????????: x1", "ST", 24, callback);
                    mIPosPrinterService.printSpecifiedTypeText("--------------------------------\n", "ST", 24, callback);
                    mIPosPrinterService.printSpecifiedTypeText("??????                18???\n\n", "ST", 32, callback);
                    mIPosPrinterService.printSpecifiedTypeText("--------------------------------\n", "ST", 24, callback);
                    mIPosPrinterService.printSpecifiedTypeText("???* 18312345678\n????????????\n", "ST", 48, callback);
                    mIPosPrinterService.printSpecifiedTypeText("--------------------------------\n", "ST", 24, callback);
                    mIPosPrinterService.printSpecifiedTypeText("  #1  ????????????\n\n\n", "ST", 48, callback);

                    mIPosPrinterService.printerPerformPrint(160,  callback);
                }catch (RemoteException e){
                    e.printStackTrace();
                }
            }
        });
    }

    /**
     * ???????????????
     * numK: ???????????????????????????4k??????????????????127???4k??????????????????0x7f
     * data: ????????????
     */
    public void bigDataPrintTest(final int numK, final byte data)
    {
        ThreadPoolManager.getInstance().executeTask(new Runnable() {
            @Override
            public void run() {
                int num4K = 1024 * 4;
                int length = numK > 127 ? num4K * 127 : num4K * numK;
                byte[] dataBytes = new byte[length];
                for (int i = 0; i < length; i++)
                {
                    dataBytes[i] = data;
                }
                try {
                    mIPosPrinterService.printRawData(dataBytes,callback);
                    mIPosPrinterService.printerPerformPrint(160,  callback);
                }catch (RemoteException e)
                {
                    e.printStackTrace();
                }
            }
        });
    }

    /**
     * ??????????????????
     */
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
                    int[] align = new int[] { 0, 2, 2, 2 }; // ??????,??????,??????,??????
                    text[0] = "??????";
                    text[1] = "??????";
                    text[2] = "??????";
                    text[3] = "??????";
                    mIPosPrinterService.printColumnsText(text, width, align, 1,callback);
                    text[0] = "????????????A??????";
                    text[1] = "4";
                    text[2] = "12.00";
                    text[3] = "48.00";
                    mIPosPrinterService.printColumnsText(text, width, align, 1,callback);
                    text[0] = "????????????????????????B";
                    text[1] = "10";
                    text[2] = "4.00";
                    text[3] = "40.00";
                    mIPosPrinterService.printColumnsText(text, width, align, 1,callback);
                    text[0] = "????????????????????????????????????"; // ????????????,??????
                    text[1] = "100";
                    text[2] = "16.00";
                    text[3] = "1600.00";
                    mIPosPrinterService.printColumnsText(text, width, align, 1,callback);
                    text[0] = "????????????????????????";
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
                    text[0] = "??????";
                    text[1] = "??????";
                    text[2] = "??????";
                    mIPosPrinterService.printColumnsText(text, width, align, 1,callback);
                    text[0] = "??????????????????";
                    text[1] = "4";
                    text[2] = "48.00";
                    mIPosPrinterService.printColumnsText(text, width, align, 1,callback);
                    text[0] = "????????????????????????B";
                    text[1] = "10";
                    text[2] = "40.00";
                    mIPosPrinterService.printColumnsText(text, width, align, 1,callback);
                    text[0] = "????????????????????????????????????"; // ????????????,??????
                    text[1] = "100";
                    text[2] = "1600.00";
                    mIPosPrinterService.printColumnsText(text, width, align, 1,callback);
                    text[0] = "????????????????????????";
                    text[1] = "10";
                    text[2] = "40.00";
                    mIPosPrinterService.printColumnsText(text, width, align, 0,callback);
                    mIPosPrinterService.printBlankLines(1, 16, callback);

                    mIPosPrinterService.setPrinterPrintAlignment(2,callback);
                    mIPosPrinterService.setPrinterPrintFontSize(16,callback);
                    text = new String[4];
                    width = new int[] { 10, 6, 6, 8 };
                    align = new int[] { 0, 2, 2, 2 }; // ??????,??????,??????,??????
                    text[0] = "??????";
                    text[1] = "??????";
                    text[2] = "??????";
                    text[3] = "??????";
                    mIPosPrinterService.printColumnsText(text, width, align, 1,callback);
                    text[0] = "????????????A??????";
                    text[1] = "4";
                    text[2] = "12.00";
                    text[3] = "48.00";
                    mIPosPrinterService.printColumnsText(text, width, align, 1,callback);
                    text[0] = "????????????????????????B";
                    text[1] = "10";
                    text[2] = "4.00";
                    text[3] = "40.00";
                    mIPosPrinterService.printColumnsText(text, width, align, 1,callback);
                    text[0] = "????????????????????????????????????"; // ????????????,??????
                    text[1] = "100";
                    text[2] = "16.00";
                    text[3] = "1600.00";
                    mIPosPrinterService.printColumnsText(text, width, align, 1,callback);
                    text[0] = "????????????????????????";
                    text[1] = "10";
                    text[2] = "4.00";
                    text[3] = "40.00";
                    mIPosPrinterService.printColumnsText(text, width, align, 0,callback);
                    mIPosPrinterService.printBlankLines(1, 10, callback);

                 /*   bmp = BitmapFactory.decodeResource(getResources(), R.mipmap.test_p);
                    mIPosPrinterService.printBitmap(0, 12, bmp, callback);
                    mIPosPrinterService.printBitmap(1, 6, bmp, callback);
                    mIPosPrinterService.printBitmap(2, 16, bmp, callback);
                    mIPosPrinterService.printBlankLines(1, 10, callback);*/

                    mIPosPrinterService.printSpecifiedTypeText("??????POS\n" +
                            "??????POS??????POS\n" +
                            "??????POS??????POS??????POS\n" +
                            "??????POS??????POS??????POS??????POS\n" +
                            "??????POS??????POS??????POS??????POS??????POS\n" +
                            "??????POS??????POS??????POS??????POS??????POS??????POS\n" +
                            "??????POS??????POS??????POS??????POS??????POS??????POS??????\n" +
                            "??????POS??????POS??????POS??????POS??????POS??????POS??????\n" +
                            "??????POS??????POS??????POS??????POS??????POS??????POS??????\n" +
                            "??????POS??????POS??????POS??????POS??????POS??????POS\n" +
                            "??????POS??????POS??????POS??????POS??????POS\n" +
                            "??????POS??????POS??????POS??????POS\n" +
                            "??????POS??????POS??????POS\n" +
                            "??????POS??????POS\n" +
                            "??????POS\n", "ST", 16, callback);
                    mIPosPrinterService.printBlankLines(1, 10, callback);
                    mIPosPrinterService.printSpecifiedTypeText("??????POS\n" +
                            "??????POS??????POS\n" +
                            "??????POS??????POS??????POS\n" +
                            "??????POS??????POS??????POS??????POS\n" +
                            "??????POS??????POS??????POS??????POS??????\n" +
                            "??????POS??????POS??????POS??????POS\n" +
                            "??????POS??????POS??????POS\n" +
                            "??????POS??????POS\n" +
                            "??????POS\n", "ST", 24, callback);
                    mIPosPrinterService.printBlankLines(1, 10, callback);
                    mIPosPrinterService.printSpecifiedTypeText("???\n" +
                            "??????\n" +
                            "?????????\n" +
                            "????????????\n" +
                            "???????????????\n" +
                            "??????????????????\n" +
                            "?????????????????????\n" +
                            "????????????????????????\n" +
                            "???????????????????????????\n" +
                            "??????????????????????????????\n" +
                            "?????????????????????????????????\n" +
                            "????????????????????????????????????" +
                            "?????????????????????????????????\n" +
                            "??????????????????????????????\n" +
                            "???????????????????????????\n" +
                            "????????????????????????\n" +
                            "?????????????????????\n" +
                            "??????????????????\n" +
                            "???????????????\n" +
                            "????????????\n" +
                            "?????????\n" +
                            "??????\n" +
                            "???\n", "ST", 32, callback);
                    mIPosPrinterService.printBlankLines(1, 10, callback);
                    mIPosPrinterService.printSpecifiedTypeText("???\n" +
                            "??????\n" +
                            "?????????\n" +
                            "????????????\n" +
                            "???????????????\n" +
                            "??????????????????\n" +
                            "?????????????????????\n" +
                            "????????????????????????" +
                            "?????????????????????\n" +
                            "??????????????????\n" +
                            "???????????????\n" +
                            "????????????\n" +
                            "?????????\n" +
                            "??????\n" +
                            "???\n", "ST", 48, callback);
                    mIPosPrinterService.printBlankLines(1, 10, callback);
                    int k = 8;
                   /* for (int i = 0; i < 48; i++)
                    {
                        bmp = BytesUtil.getLineBitmapFromData(12, k);
                        k += 8;
                        if (null != bmp)
                        {
                            mIPosPrinterService.printBitmap(1, 11, bmp, callback);
                        }
                    }*/
                    mIPosPrinterService.printBlankLines(1, 10, callback);
                    /*??????bitmap???????????????????????????*/
                   // bitmapRecycle(bmp);
                    mIPosPrinterService.printerPerformPrint(160,  callback);
                }catch (RemoteException e){
                    e.printStackTrace();
                }
            }
        });
    }

    /**
     * ????????????????????????
     */
  /*  public void inputBytes(final int flag)
    {
        final EditText inputServer = new EditText(this);
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle("Server").setIcon(android.R.drawable.ic_dialog_info).setView(inputServer).setNegativeButton("Cancel", null);
        builder.setPositiveButton("Ok", new DialogInterface.OnClickListener()
        {

            public void onClick(DialogInterface dialog, int which)
            {
                byte[] inputCommand;
                inputCommand = BytesUtil.getBytesFromHexString(inputServer.getText().toString());
                System.out.println(BytesUtil.getHexStringFromBytes(inputCommand));
                if (null != inputCommand)
                {
                    switch (flag)
                    {
                        //????????????????????????????????????????????????????????????4k?????????????????????????????????????????????
                        case 1:
                            bigDataPrintTest((int) inputCommand[0], inputCommand[1]);
                            break;
                        //????????????
                        case 2:
                            loopPrintFlag = INPUT_CONTENT_LOOP_PRINT;
                            loopContent = inputCommand[0];
                            bigDataPrintTest(127, loopContent);
                            break;
                    }


                }
            }
        });
        builder.show();
    }*/

    /**
     * ??????????????????
     */
    public void continuPrint()
    {
        ThreadPoolManager.getInstance().executeTask(new Runnable() {
            @Override
            public void run() {
                //Bitmap bmp = BitmapFactory.decodeResource(getResources(), R.mipmap.test);
                try{
                    mIPosPrinterService.printSpecifiedTypeText(customCHR, "ST", 16, callback);
                    mIPosPrinterService.printSpecifiedTypeText(Text, "ST", 16, callback);
                    mIPosPrinterService.printSpecifiedTypeText(customCHR, "ST", 24, callback);
                    mIPosPrinterService.printSpecifiedTypeText(Text, "ST", 24, callback);
                    mIPosPrinterService.printSpecifiedTypeText(customCHR, "ST", 32, callback);
                    mIPosPrinterService.printSpecifiedTypeText(Text, "ST", 32, callback);
                    mIPosPrinterService.printSpecifiedTypeText(customCHR, "ST", 48, callback);
                    mIPosPrinterService.printSpecifiedTypeText(customCHZ1, "ST", 48, callback);
                    mIPosPrinterService.printBlankLines(1, 10, callback);
/*
                    mIPosPrinterService.printBitmap(0, 4, bmp, callback);
                    mIPosPrinterService.printBlankLines(1, 20, callback);
                    mIPosPrinterService.printBitmap(0, 5, bmp, callback);
                    mIPosPrinterService.printBlankLines(1, 20, callback);
                    mIPosPrinterService.printBitmap(0, 6, bmp, callback);
                    mIPosPrinterService.printBlankLines(1, 20, callback);
                    mIPosPrinterService.printBitmap(0, 7, bmp, callback);
                    mIPosPrinterService.printBlankLines(1, 20, callback);
                    mIPosPrinterService.printBitmap(0, 8, bmp, callback);
                    mIPosPrinterService.printBlankLines(1, 20, callback);

                    mIPosPrinterService.printBitmap(1, 9, bmp, callback);
                    mIPosPrinterService.printBlankLines(1, 20, callback);
                    mIPosPrinterService.printBitmap(1, 10, bmp, callback);
                    mIPosPrinterService.printBlankLines(1, 20, callback);
                    mIPosPrinterService.printBitmap(1, 11, bmp, callback);
                    mIPosPrinterService.printBlankLines(1, 20, callback);
                    mIPosPrinterService.printBitmap(1, 12, bmp, callback);
                    mIPosPrinterService.printBlankLines(1, 20, callback);
                    mIPosPrinterService.printBitmap(1, 13, bmp, callback);
                    mIPosPrinterService.printBlankLines(1, 20, callback);

                    mIPosPrinterService.printBitmap(2, 12, bmp, callback);
                    mIPosPrinterService.printBlankLines(1, 20, callback);
                    mIPosPrinterService.printBitmap(3, 11, bmp, callback);
                    mIPosPrinterService.printBlankLines(1, 20, callback);
                    mIPosPrinterService.printBitmap(4, 10, bmp, callback);
                    mIPosPrinterService.printBlankLines(1, 20, callback);
                    mIPosPrinterService.printBitmap(5, 9, bmp, callback);
                    mIPosPrinterService.printBlankLines(1, 20, callback);
                    mIPosPrinterService.printBitmap(6, 8, bmp, callback);*/
                    mIPosPrinterService.printBlankLines(1, 20, callback);
                    /*??????bitmap???????????????????????????*/
                   // bitmapRecycle(bmp);

                    mIPosPrinterService.printerPerformPrint(160,  callback);
                }catch (RemoteException e){
                    e.printStackTrace();
                }
            }
        });
    }

    /**
     * ????????????
     */
    public void wavePrintTest()
    {
        ThreadPoolManager.getInstance().executeTask(new Runnable() {
            @Override
            public void run() {
                int length = 100;
                byte[] data = new byte[48 * length * 5];
                for (int i = 0; i < length; i++)
                {
                    for (int x = 0; x < 5; x++)
                    {
                        for (int j = 0; j < 48; j++)
                        {
                            if (i % 2 != 0)
                            {
                                data[48 * (5 * i + x) + j] = (byte) 0xff;
                            }
                            else
                            {
                                data[48 * (5 * i + x) + j] = (byte) 0x01;
                            }
                        }
                    }
                }
                try {
                    mIPosPrinterService.printRawData(data, callback);
                    mIPosPrinterService.printSpecifiedTypeText("\n" +
                            "????????????????????????????????????????????????????????????????????????\n" +
                            "???\n" +
                            "????????????????????????????????????????????????????????????????????????\n" +
                            "???????????????\n" +
                            "???                                                   " +
                            "??????   ??????   ??????  ??????\n" +
                            "???\n" +
                            "????????????????????????????????????????????????????????????????????????\n" +
                            "?????????\n" +
                            "??????\n" +
                            "???\n" +
                            "                                     " +
                            "                                     " +
                            "??????????????????????????????????????????????????????\n" +
                            "?????????\n" +
                            "???\n" +
                            "???\n" +
                            "????????????????????????\n" +
                            "\n" +
                            "??????????????????????????????????????????\n" +
                            "???????????????\n" +
                            "??????????????????\n" +
                            "??????????????????\n" +
                            "???\n", "ST", 16, callback);
                    mIPosPrinterService.printSpecifiedTypeText("\n" +
                            "????????????????????????????????????????????????????????????????????????????????????????????????\n" +
                            "???\n" +
                            "???????????????????????????????????????????????????????????????????????????????????????\n" +
                            "???????????????\n" +
                            "???                                                   " +
                            "??????   ??????   ??????  ??????\n" +
                            "???\n" +
                            "????????????????????????????????????????????????????????????????????????????????????????????????\n" +
                            "?????????\n" +
                            "??????\n" +
                            "???\n" +
                            "                                     " +
                            "                                     " +
                            "???????????????????????????????????????\n" +
                            "?????????\n" +
                            "???\n" +
                            "???\n" +
                            "????????????????????????\n" +
                            "\n" +
                            "??????????????????????????????????????????\n" +
                            "???????????????\n" +
                            "??????????????????\n" +
                            "??????????????????\n" +
                            "???\n", "ST", 24, callback);
                    mIPosPrinterService.printSpecifiedTypeText("\n" +
                            "????????????????????????????????????????????????????????????????????????????????????????????????\n" +
                            "???\n" +
                            "???????????????????????????????????????????????????????????????????????????????????????\n" +
                            "???????????????\n" +
                            "???                                                   " +
                            "??????   ??????   ??????  ??????\n" +
                            "???\n" +
                            "????????????????????????????????????????????????????????????????????????????????????????????????\n" +
                            "?????????\n" +
                            "??????\n" +
                            "???\n" +
                            "                                     " +
                            "                                     " +
                            "???????????????????????????????????????\n" +
                            "?????????\n" +
                            "???\n" +
                            "???\n" +
                            "????????????????????????\n" +
                            "\n" +
                            "??????????????????????????????????????????\n" +
                            "???????????????\n" +
                            "??????????????????\n" +
                            "??????????????????\n" +
                            "???\n", "ST", 32, callback);
                    mIPosPrinterService.printerPerformPrint(160,  callback);
                }catch (RemoteException e){
                    e.printStackTrace();
                }
            }
        });
    }

    /**
     * ????????????
     */
    public void loopPrint(int flag)
    {
        switch (flag)
        {
            case MULTI_THREAD_LOOP_PRINT:
                multiThreadLoopPrint();
                break;
            case DEMO_LOOP_PRINT:
                demoLoopPrint();
                break;
            case INPUT_CONTENT_LOOP_PRINT:
                bigDataPrintTest(127, loopContent);
                break;
            case PRINT_DRIVER_ERROR_TEST:
                printDriverTest();
                break;
            default:
                break;
        }
    }

    /**
     * ?????????????????????
     */
    public void multiThreadLoopPrint()
    {
        Log.e(TAG, "?????????????????? --> ");
        switch (random.nextInt(12))
        {
            case 0:
                printText();
                break;
            case 1:
                printBarcode();
                break;
            case 2:
                fullTest();
                break;
            case 3:
                printQRCode();
                break;
            case 4:
                printBitmap();
                break;
            case 5:
                printTable();
                break;
            case 6:
                printBaiduBill();
                break;
            case 7:
                printKoubeiBill();
                break;
            case 8:
                printMeiTuanBill();
                break;
            case 9:
                printErlmoBill();
                break;
            case 10:
                printSelf();
                break;
            case 11:
                continuPrint();
                break;
            default:
                break;
        }
    }

    public void demoLoopPrint()
    {
        Log.e(TAG, "?????????????????? --> ");
        switch (random.nextInt(7))
        {
            case 0:
                printKoubeiBill();
                break;
            case 1:
                printBarcode();
                break;
            case 2:
                printBaiduBill();
                break;
            case 3:
                printBitmap();
                break;
            case 4:
                printErlmoBill();
                break;
            case 5:
                printQRCode();
                break;
            case 6:
                printMeiTuanBill();
                break;
            default:
                break;
        }
    }

    /**
     * ?????????????????????64k????????????????????????512k
     */
    public void printDriverTest()
    {
        if (printDriverTestCount >= 8)
        {
            loopPrintFlag = DEFAULT_LOOP_PRINT;
            printDriverTestCount = 0;
        }
        else
        {
            printDriverTestCount++;
            bigDataPrintTest(printDriverTestCount * 16, (byte) 0x11);
        }
    }
}
