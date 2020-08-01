package com.astitva.filetransfer;
import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.net.wifi.WifiConfiguration;
import android.net.wifi.WifiManager;
import android.util.Log;
import androidx.annotation.NonNull;

import java.io.File;

import java.util.HashMap;
import java.util.List;
import java.util.Random;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;


public class MainActivity extends FlutterActivity {
    String TAG="hello";
    HashMap<String, String> files;
    Context context;
    private static final String CHANNEL = "filetransfer";
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {

        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("getPlatformVersion")) {
                                result.success("Android " + android.os.Build.VERSION.RELEASE);
                            }else if (call.method.equals("getapkpath")) {
                                HashMap<String, String> installedApkFilePathss = getAllInstalledApkFiles(context);
                                result.success(installedApkFilePathss);
                            }else  if (call.method.equals("getapk")){
                                String s =call.argument("packages");
                                File apkfile = getApkFile(context,s);
                                result.success(apkfile);
                            }
                            else {
                                result.notImplemented();
                            }
                        }
                );
    }
    private HashMap<String, String> getAllInstalledApkFiles(Context context) {


        HashMap<String, String> installedApkFilePaths = new HashMap<>();

        PackageManager packageManager = getPackageManager();
        @SuppressLint("WrongConstant") List<PackageInfo> packageInfoList = packageManager.getInstalledPackages(PackageManager.SIGNATURE_MATCH);

        if (isValid(packageInfoList)) {
            for (PackageInfo packageInfo : packageInfoList) {
                ApplicationInfo applicationInfo;

                applicationInfo = getApplicationInfoFrom(packageManager, packageInfo);

                String packageName = applicationInfo.packageName;
                String versionName = packageInfo.versionName;
                int versionCode = packageInfo.versionCode;

                File apkFile = new File(applicationInfo.sourceDir);
                if (apkFile.exists()) {
                    installedApkFilePaths.put(packageName, apkFile.getAbsolutePath());
                    Log.d(TAG, packageName + " = " + apkFile.getName());
                }
            }
        }
        return  installedApkFilePaths;

    }


    private boolean isValid(List<PackageInfo> packageInfos) {
        return packageInfos != null && !packageInfos.isEmpty();
    }


    private ApplicationInfo getApplicationInfoFrom(PackageManager packageManager, PackageInfo packageInfo) {
        return packageInfo.applicationInfo;
    }
    public File getApkFile(Context context, String packageName) {
        HashMap<String, String> installedApkFilePaths = getAllInstalledApkFiles(context);
        File apkFile = new File(installedApkFilePaths.get(packageName));
        if (apkFile.exists()) {
            return apkFile;
        }

        return null;
    }




}

