package mes.web.file;

import java.io.File;
import java.sql.Blob;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import mes.web.ut.FileUtil;
import mes.web.ut.Utils;

@Controller
public class FileController {
	
	private static final Logger logger = LoggerFactory.getLogger(FileController.class);
	
	// 파일 업로드
	@ResponseBody
	@RequestMapping(value = "file/fileUpload", method = RequestMethod.POST)
	public Map<String, Object> fileUpload( MultipartHttpServletRequest multipartRequest) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("파일 업로드");
		
		try {
			String filePath = Utils.getFilePath();
		    
		    File dir = new File(filePath); //파일 저장 경로 확인, 없으면 만든다.
		    if (!dir.exists()) {
		        dir.mkdirs();
		    }
		    
		    Iterator<String> itr =  multipartRequest.getFileNames(); //파일들을 Iterator 에 넣는다.
		    int i = 0;
		    while (itr.hasNext()) { //파일을 하나씩 불러온다.
		    	MultipartFile mpf = multipartRequest.getFile(itr.next());
		    	String uuid = multipartRequest.getParameterValues("uuid")[i].toString();
		    	String ext = multipartRequest.getParameterValues("ext")[i].toString();
		    	
		    	String fileFullPath = filePath + uuid + "." + ext;
		    	
			    logger.info(fileFullPath);
		    	mpf.transferTo(new File(fileFullPath)); //파일저장
		    	i++;
		    }
		    
		    jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
			logger.error("파일 업로드 오류 : " + Utils.getErrorMessage() );
		}
	    return jsonData;
	}
	
	// 파일 다운로드
	@RequestMapping(value = "file/fileDownload", method = RequestMethod.GET)
	public @ResponseBody ModelAndView fileDownload(ModelAndView mv, String uuid, String fileName, String ext) throws Exception {
		logger.info("파일 다운로드");
		try {
			String filePath = Utils.getFilePath();
		    
		    filePath += uuid + "." + ext;
		    
		    File file = new File(filePath);
		    
		    ModelAndView model = new ModelAndView("downloadView", "downloadFile", file);
		    model.addObject("fileName", fileName+"."+ext);
    		
            return model;
		} catch (Exception e) {
			e.printStackTrace();
			return new ModelAndView();
		}
	}
	
	// 파일 삭제
	@ResponseBody
	@RequestMapping(value = "file/fileDelete", method = RequestMethod.POST)
	public Map<String, Object> fileDelete(@RequestParam(value="uuid") String uuid,
											@RequestParam(value="ext") String ext) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("파일 삭제");
		try {
			String filePath = Utils.getFilePath();
		    
		    filePath += uuid + "." + ext;
		    
		    File file = new File(filePath);
		    
		    file.delete();
		    jsonData.put("result", "ok");
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
			logger.error("파일 삭제 오류 : " + Utils.getErrorMessage() );
		}
		return jsonData;
	}
	
	// 파일 BLOB 조회
	@RequestMapping(value = "file/getFileBlob", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> getFileBlob(String uuid, String ext) throws Exception {
		Map<String, Object> jsonData = new HashMap<String, Object>();
		logger.info("파일 BLOB 조회");
		
		try {
			String filePath = Utils.getFilePath() + uuid + "." + ext;
		    
		    File file = new File(filePath);
		    
		    byte[] blob = FileUtils.readFileToByteArray(file);
		    
		    jsonData.put("result", "ok");
		    jsonData.put("data", blob);
		} catch (Exception e) {
			e.printStackTrace();
			jsonData.put("result", "error");
			jsonData.put("message", Utils.getErrorMessage());
		}
	    return jsonData;
	}
}
