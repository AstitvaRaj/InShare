package com.astitva.filetransfer;
import android.annotation.SuppressLint;
import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.util.Log;

import java.io.File;
import java.util.HashMap;
import java.util.List;

public class gapkfiles {
    static String TAG="apkfiles";
    public static HashMap<String, String> getAllInstalledApkFiles(Context context) {
        HashMap<String, String> installedApkFilePaths = new HashMap<>();

        PackageManager packageManager = context.getPackageManager();
        @SuppressLint("WrongConstant") List<PackageInfo> packageInfoList = packageManager.getInstalledPackages(PackageManager.SIGNATURE_MATCH);

        if (isValid(packageInfoList)) {
            for (PackageInfo packageInfo : packageInfoList) {
                ApplicationInfo applicationInfo;

                applicationInfo = getApplicationInfoFrom(packageManager, packageInfo);

                String packageName = applicationInfo.packageName;
                String versionName = packageInfo.versionName;
                int versionCode = packageInfo.versionCode;

                File apkFile = new File(applicationInfo.publicSourceDir);
                if (apkFile.exists()) {
                    installedApkFilePaths.put(packageName, apkFile.getAbsolutePath());
                    Log.d(TAG, packageName + " = " + apkFile.getName());
                }
            }
        }

        return installedApkFilePaths;
    }
    private static boolean isValid(List<PackageInfo> packageInfos) {
        return packageInfos != null && !packageInfos.isEmpty();
    }

    private static ApplicationInfo getApplicationInfoFrom(PackageManager packageManager, PackageInfo packageInfo) {
        return packageInfo.applicationInfo;
    }

}
