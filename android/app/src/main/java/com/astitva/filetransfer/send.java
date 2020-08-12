package com.astitva.filetransfer;

import android.annotation.SuppressLint;
import android.os.Build;

import androidx.annotation.RequiresApi;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.net.SocketAddress;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;
import java.nio.channels.ServerSocketChannel;
import java.nio.channels.SocketChannel;
import java.nio.file.Path;
import java.nio.file.Paths;

public class send implements Runnable{
    static String p = "";

    @RequiresApi(api = Build.VERSION_CODES.O)
    public static void start() throws IOException {
        send client = new send();
        //SocketChannel socketChannel = client.CreateChannel();
        SocketChannel socketChannel = client.create();
        System.out.println(socketChannel.getLocalAddress());
        client.sendfile(socketChannel);
        socketChannel.close();

    }
    public  void setpath(String path){
        p = path;
    }

    @RequiresApi(api = Build.VERSION_CODES.O)
    private void sendfile(SocketChannel socketChannel) throws IOException{
        System.out.println("PATH:  "+p);
        Path path = Paths.get(p);
        System.out.println(path);
        FileChannel iChannel = FileChannel.open(path);
        ByteBuffer buffer = ByteBuffer.allocate(10485760);
        while(iChannel.read(buffer)>0){
            buffer.flip();
            System.out.print(buffer);
            socketChannel.write(buffer);
            buffer.clear();
        }
        socketChannel.close();

    }

    private SocketChannel create() throws IOException{
        ServerSocketChannel serversocket = null;
        SocketChannel client = null;
        serversocket = ServerSocketChannel.open();
        serversocket.socket().bind(new InetSocketAddress(4567));
        client = serversocket.accept();
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            System.out.println("Connection Succ."+ client.getRemoteAddress());
        }
        return client;
    }
    private SocketChannel CreateChannel() throws IOException{
        SocketChannel socketChannel = SocketChannel.open();
        SocketAddress socketAddress = new InetSocketAddress("192.168.43.172",4567);
        socketChannel.connect(socketAddress);
        return socketChannel;
    }

    @RequiresApi(api = Build.VERSION_CODES.O)
    @Override
    public void run() {
        try {
            start();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}