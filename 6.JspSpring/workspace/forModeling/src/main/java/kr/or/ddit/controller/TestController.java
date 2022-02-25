package kr.or.ddit.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.service.MemberService;

@Controller
public class TestController {

	@Autowired
	private MemberService memberService = null;

	@RequestMapping("/jsQR/jsQRTest")
	public void jsQRTest() {
	}

	@RequestMapping("/member/getSeq")
	public String getSeq(Model model) throws Exception {
		String url = "/member/sequenceTest";

		File memberLoginLog = new File("c:/log/memberLoginLog.xlsx");

		String msg = "";
		if (memberLoginLog.exists()) {

			FileInputStream fis = FileUtils.openInputStream(memberLoginLog);
			Workbook wb = new XSSFWorkbook(fis);
			Sheet sheet = wb.getSheetAt(0);

			int lastRow = sheet.getLastRowNum();

			for (int i = lastRow; i < lastRow + 200; i++) {
				Row row = sheet.createRow(i);
				Cell cell1 = row.createCell(0);
				Cell cell2 = row.createCell(1);
				Cell cell3 = row.createCell(2);
				int seqVal = memberService.getMberSequence();
				String memberInnb = "MBER" + String.valueOf(seqVal);
				cell1.setCellValue(memberInnb);
				String loginYN = (Math.random() * 2) > 1 ? "LOGIN" : "LOGOUT";
				cell2.setCellValue(loginYN);
				String date = new SimpleDateFormat("yyyyMMdd").format(new Date());
				cell3.setCellValue(date);

			}

			try (FileOutputStream fos = new FileOutputStream(memberLoginLog)) {
				wb.write(fos);
			}

			msg = "success";

		} else {
			msg = "fail";
		}
		model.addAttribute("result", msg);

		return url;
	}

	@RequestMapping("/member/getLog")
	public void getLog(Model model) throws Exception {
		String msg = "";
		File memberLoginLog = new File("c:/log/memberLoginLog.xlsx");

		if (memberLoginLog.exists()) {

			try (FileInputStream fis = FileUtils.openInputStream(memberLoginLog)) {
				DataFormatter formatter = new DataFormatter();
				Workbook wb = new XSSFWorkbook(fis);
				Sheet sheet = wb.getSheetAt(0);

				int lastRow = sheet.getLastRowNum();

				List<Map<String, String>> testList = new ArrayList<Map<String, String>>();

				for (int i = 0; i < lastRow; i++) {
					Row row = sheet.getRow(i);
					Cell cell1 = row.getCell(0);
					Cell cell2 = row.getCell(1);
					Cell cell3 = row.getCell(2);

					/*
					 * CellReference cellRef = new CellReference(row.getRowNum(),
					 * cell1.getColumnIndex()); System.out.print(cellRef.formatAsString());
					 * System.out.print(" - ");
					 */

					/*String text = formatter.formatCellValue(cell1);*/

					/*
					 * switch (cell1.getCellType()) { case STRING:
					 * System.out.println(cell1.getRichStringCellValue().getString()); break; case
					 * NUMERIC: if (DateUtil.isCellDateFormatted(cell1)) {
					 * System.out.println(cell1.getDateCellValue()); } else {
					 * System.out.println(cell1.getNumericCellValue()); } break; case BOOLEAN:
					 * System.out.println(cell1.getBooleanCellValue()); break; case FORMULA:
					 * System.out.println(cell1.getCellFormula()); break; case BLANK:
					 * System.out.println(); break; default: System.out.println(); }
					 */

					Map<String, String> loginLog = new HashMap<String, String>();
					loginLog.put("MBER_INNB", cell1.getStringCellValue());
					loginLog.put("LOG_TYPE", cell2.getStringCellValue());
					loginLog.put("LOG_DATE", cell3.getStringCellValue());

					testList.add(loginLog);
				}

				for (Map<String, String> loginLog : testList) {
					StringBuffer logText = new StringBuffer("");
					logText.append(" MBER_INNB : ");
					logText.append(loginLog.get("MBER_INNB"));
					logText.append(" LOG_TYPE : ");
					logText.append(loginLog.get("LOG_TYPE"));
					logText.append(" LOG_DATE : ");
					logText.append(loginLog.get("LOG_DATE"));

					System.out.println(logText.toString());
				}

			}

		}
	}

	@RequestMapping("/pbhlth/list")
	public void list() {}
}
