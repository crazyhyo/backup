/*
 * 21/09/03 
 * author : Lee KwangHyo
 */

package kr.or.ddit.basic;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class FileUtil {

  public static void displayFileList(File dir){
      System.out.println("[" + dir.getAbsolutePath() + "] 디렉토리의 내용"); 
    
      File[] files = dir.listFiles();

      List<Integer> subDirList = new ArrayList<Integer>();

      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd a hh:mm");

      for(int i=0; i<files.length; i++){
          String attr = "";
          String size = "";

          if(files[i].isDirectory()){
              attr = "<DIR>";
              subDirList.add(i);
          }else{
              size = files[i].length() + "";
              attr = files[i].canRead() ? "R" : " "; 
              attr += files[i].canWrite() ? "W" : " "; 
              attr += files[i].isHidden() ? "H" : " "; 
          }
          System.out.printf("%s|%-5s|%-12s|%s\n",
                  sdf.format(new Date(files[i].lastModified())),
                  attr, size, files[i].getName());
      }


      int dirCount = subDirList.size();
      int fileCount = files.length - dirCount;

      System.out.println(fileCount + "개의 파일, " + dirCount + "개의 디렉토리");
      System.out.println();

      for(int i=0; i<dirCount; i++){
          displayFileList(files[subDirList.get(i)]);
      }
  }

}
