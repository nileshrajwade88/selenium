package com.pru.pageobjects;
import java.awt.AWTException;
import java.awt.Toolkit;
import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.StringSelection;
import java.awt.event.KeyEvent;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.Period;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;
import java.util.concurrent.TimeUnit;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.text.PDFTextStripper;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.FindBy;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

import com.pru.pageobjects.PruWealth_ContributionPage;
import com.pru.testscripts.BaseTest;
import com.pru.utilities.CommonFunction;
import com.pru.utilities.ExtentReport;
import com.pru.utilities.PageInitiator;
import com.pru.utilities.TestDataProvider;
public class testing  extends BaseTest {
	
	
	@FindBy(xpath="/html/body/div[1]/div[1]/div/div[1]/div[2]/div[5]/div[1]")
	private static WebElement sonataappdate;
	@FindBy(css="div>h1")
	private static WebElement errorMessage;
	
	@Parameters({"TestId"})
	@Test(priority=1)	
	public void testonly(String testId) throws Throwable {
		// TODO Auto-generated method stub
		driver.navigate().to("http://sys1.docview.pru.local:8443/document-viewer/view/viewDocument?documentId=PSI113133258");
		
		boolean flag = CommonFunction.isAvailableObject(errorMessage, 100);
		System.out.println("Availability : " + flag);
	    
		
	}



	

}
