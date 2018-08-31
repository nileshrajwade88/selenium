PruWealth_ClientCreationPage.ja
package com.pru.pageobjects;


/***********************************************************************************************************************************
 * 		AUTHOR		::	Gurpreet Kaur	
 *		File Name 	::	PruWealth_ClientCreation.java from Page Objects
 *		Description	::	Class is used to create client ID
 **********************************************************************************************************************************/

import java.io.IOException;

import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;

import com.pru.utilities.CommonFunction;
import com.pru.utilities.ExtentReport;
import com.pru.utilities.PageInitiator;
import com.pru.utilities.TestBase;
import com.pru.utilities.TestDataProvider;

public class PruWealth_ClientCreationPage extends PageInitiator {
	

	@FindBy(css="a[href='/kaedwen/ria/client/applications']")
	private WebElement illustrateandapplylink;
	@FindBy(css="button[id='newJourneyButtonsForm:newIllustration']")
	private WebElement sonata_NewIllustration;
	@FindBy(css="select#title")
	private WebElement client_Title;
	@FindBy(css="input#clientDetailsForname")
	private static WebElement forenames;
	@FindBy(css="input#clientDetailsSurname")
	private static WebElement surname;
	@FindBy(css="input#clientDOB_input")
	private static WebElement dateOfBirth;
	@FindBy(css="input#preferRetirementAge")
	private static WebElement preferRetirementAge;
	@FindBy(css="select#gender")
	private static WebElement gender;
	@FindBy(css="button[id='nextAction']")
	private static WebElement nextButton;
	@FindBy(css="button[id='addNewAccount']")
	private WebElement addnewaccount;
	@FindBy(xpath="/html/body/div[1]/div[1]/div/div[1]/div[2]/div[5]/div[1]")
	private static WebElement sonataappdate;
	
	@FindBy(css="span.ui-messages-error-summary")
	private WebElement clienterrorMessage;
	
	
	public void clientCreation(String testId) throws Exception{
		try{
			//System.out.println("Illusterate page");
			click("Click on Illusterate and Apply" ,illustrateandapplylink, testId );
			click("Click on New Illusteration" ,sonata_NewIllustration, testId );
			CommonFunction.waitTillObjectExist(client_Title,testId);
			int noOfComponents = TestDataProvider.getTestCaseCountFromSheet("ClientDetailsPage",testId);
			//System.out.println("testId : " +testId);
			//System.out.println("noOfComponents : " + noOfComponents);
			int rowNumber = TestDataProvider.getRowNumber("ClientDetailsPage", testId);
			for (int i=1;i<noOfComponents+1;i++){
				//System.out.println("i : " + i);
				NewSheetTestData = TestDataProvider.testsheet_DetailedInformation("ClientDetailsPage", testId, rowNumber);					
					clientCreationData(i-1,testId);
					rowNumber++;
				}										
				
			} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		}
	
		public void clientCreationData(int index,String testId) throws InterruptedException, Exception{
			try{
			CommonFunction.SelectValueByIndex(client_Title,NewSheetTestData.get("Title"),"Title",index,testId);
			CommonFunction.EnterValueByIndex(forenames, NewSheetTestData.get("Forename"), "Forename", index,testId);
			CommonFunction.EnterValueByIndex(surname, NewSheetTestData.get("Surname"), "Surname", index,testId);
			
			String strSystemDate = CommonFunction.GetSystemDateFromApplication(sonataappdate);			
			String DOB = CommonFunction.GetDateOfBirth(strSystemDate,Integer.parseInt(NewSheetTestData.get("Prefer_Retirement_Age")),NewSheetTestData.get("Year"),NewSheetTestData.get("Month"));
			
			CommonFunction.EnterValueByIndex(dateOfBirth,DOB, "Date_Of_Birth", index,testId);
			CommonFunction.SelectValueByIndex(gender,NewSheetTestData.get("Gender"),"Gender",index,testId);
			CommonFunction.EnterValueByIndex(preferRetirementAge, NewSheetTestData.get("Prefer_Retirement_Age"), "Prefer_Retirement_Age", index,testId);
			
			click("Click on Next button" ,nextButton, testId );
			//CommonFunction.isAvailableObject(errorMessage, 1)
			try{
				if(clienterrorMessage.isDisplayed()){
					System.out.println("Error Message dispalyed: " + clienterrorMessage.getText());
					ExtentReport.reportFail("Client Creation : Error Message dispalyed : " + clienterrorMessage.getText(),testId);
				}			
			} catch(Exception e){}

			CommonFunction.waitTillObjectNotExist(addnewaccount,testId);
			if(TestBase.verifyElementDisplayed("Asset Selection Page" , addnewaccount, testId )){
				ExtentReport.reportPass("Select Account page successfully displayed");
			}
			
			} catch (Exception e) {
			// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
}
			

	
	





