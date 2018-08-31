
package com.pru.pageobjects;

import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;

import com.pru.utilities.CommonFunction;
import com.pru.utilities.ExtentReport;
import com.pru.utilities.PageInitiator;
import com.pru.utilities.TestBase;
import com.pru.utilities.TestDataProvider;

public class PruWealth_AdditionalInformationPage extends PageInitiator {
	@FindBy(css="select[id*='disinvestmentMethod']")
	private WebElement InstructionProfile;
	@FindBy(css="input[id*='includeGuaranteedUnitsCheckbox']")
	private WebElement InstructionProfileCheckbox;
	@FindBy(css="table[id*='disinvestmentSplit']")
	private static WebElement AssetTable;
	@FindBy(css="input[id*=disinvestmentPercentage]")
	private static WebElement DisinvestmentPercentage;
	@FindBy(css="input[id*='retirementAge']")
	private WebElement RetirementAge;
	@FindBy(css="select[id*='guaranteePeriod']")
	private WebElement GuaranteePeriod;
	@FindBy(css="select[id*='escalationRate']")
	private WebElement EscalationRate;
	@FindBy(css="select[id*='spouseBenefit']")
	private WebElement SpouseBenefit;
	@FindBy(css="button[id*='nextAction']")
	private WebElement AdditionalInformationNextButton;
	@FindBy(css="a[id*=':summaryLink']")
	private WebElement confirm_viewSummaryLink;
	@FindBy(css="input[id*='fundSearchCriteriaManual']")
	private WebElement addinfofundsearchcriteriamanual;
	@FindBy(css="button[id*='fundSearchAction']")
	private WebElement addinfofundsearchaction;
	@FindBy(css="button[id*='disinvestment:j_idt'][class*='ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only image-button add-button']")
	private WebElement addinfoplusbtnofassetsearch;
	@FindBy(css="button[id*='disinvestment:fundSearchDialogOkAction'][class*='ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only']")
	private WebElement addinfoassetclosebutton;
	@FindBy(css="input[id*='rebalancingOptions:doNotIncludeInRebalancing'][type='checkbox']")
	private WebElement rebalancingdonotrebalanc;
	@FindBy(css="select[id*='rebalancingOptions:rebalancingFrequencySelection']")
	private WebElement rebalancingfrequency;
	@FindBy(css="input[id*='rebalancingOptions:rebalanceDueDateInput_input']")
	private WebElement rebalancingDate;
	
	@FindBy(css="span.ui-messages-error-summary")
	private WebElement errorMessage;
	
	boolean instructionType;
	int noOfComponents, i, j;
	int indexInstructionProfile;
	
	public void PensionSavingsOACDisinvestmentInstruction(String testId) throws Throwable {
		try {
	
			noOfComponents = TestDataProvider.getTestCaseCountFromSheet("AdditionalInformation",testId);
			//System.out.println(noOfComponents);
			int rowNumber = TestDataProvider.getRowNumber("AdditionalInformation", testId);
			for (i=1;i<noOfComponents+1;i++){
				AdditionalInformationTestData = TestDataProvider.testsheet_DetailedInformation("AdditionalInformation", testId, rowNumber);
				
				if (AdditionalInformationTestData.get("InstructionType").equalsIgnoreCase("Specific assets")) {
					instructionType = true;
					indexInstructionProfile = indexInstructionProfile+1;
				}	
				
				FillDetails(i-1,instructionType,indexInstructionProfile-1,testId);
				rowNumber++;
			}
			scrollintoview(SpouseBenefit);
			if(AdditionalInformationTestData.get("RebalancingCheckBox").equalsIgnoreCase("Y"))
				CommonFunction.CheckValueByIndex(rebalancingdonotrebalanc,"Instruction Profile Checkbox",0,testId);
			//System.out.println("NewSheetTestData.get(RebalancingFrequency).equals(null) : " + AdditionalInformationTestData.get("RebalancingFrequency").equals(null));
			//if(!AdditionalInformationTestData.get("RebalancingFrequency").equals(null)&& (!(NewSheetTestData.get("RebalancingFrequency").length()==0)))
			if(!AdditionalInformationTestData.get("RebalancingFrequency").equals(null)&& ((AdditionalInformationTestData.get("RebalancingFrequency").length()!=0)))
				CommonFunction.SelectValueByIndex(rebalancingfrequency,AdditionalInformationTestData.get("RebalancingFrequency") , "Rebalancing Frequency", 0 ,testId);			
			
			String EscRate = AdditionalInformationTestData.get("EscalationRate");
			if(!AdditionalInformationTestData.get("EscalationRate").equalsIgnoreCase("RPI"))
				EscRate= EscRate+"%";
			CommonFunction.EnterValueByIndex(RetirementAge,AdditionalInformationTestData.get("RetirementAge"),"Retirement Age",0,testId);
			CommonFunction.SelectValueByIndex(GuaranteePeriod,AdditionalInformationTestData.get("GuaranteePeriod"),"Guarantee Period",0,testId);
			CommonFunction.SelectValueByIndex(EscalationRate,EscRate,"Escalation Rate",0,testId);
			CommonFunction.SelectValueByIndex(SpouseBenefit,AdditionalInformationTestData.get("SecondLifeBenefit"),"Spouse Benefit",0,testId);
			 
			click("Click on Next Button from Additional Information Page : ", AdditionalInformationNextButton, testId);
			
			try{				
				if(errorMessage.isDisplayed()){
					System.out.println("Error Message dispalyed syso: " + errorMessage.getText());
					ExtentReport.reportFail("Additional Information : Error Message dispalyed : " + errorMessage.getText(),testId);
				}
			} catch(Exception e){}
			
			CommonFunction.waitTillObjectNotExist(confirm_viewSummaryLink,testId);
			if(TestBase.verifyElementDisplayed("Confirm Page" , confirm_viewSummaryLink, testId ))
				ExtentReport.reportPass("Confirm page successfully displayed");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void FillDetails(int index, boolean instructionType, int indexInstructionProfile, String testId) throws Throwable {
		// TODO Auto-generated method stub
		try {
			Thread.sleep(3500);
			//System.out.println("Index : " + index);
			//System.out.println("Instruction Type : " + instructionType);
			//System.out.println("indexInstructionProfile : " + indexInstructionProfile);
			
			System.out.println("Selected Instruction Profile : " + AdditionalInformationTestData.get("InstructionType"));
			CommonFunction.SelectValueByIndex(InstructionProfile,AdditionalInformationTestData.get("InstructionType"),"Selected Instruction Profile",index,testId);
			
			System.out.println("Instruction Profile Checkbox : " + AdditionalInformationTestData.get("OACCheckBox"));
			CommonFunction.CheckValueByIndex(InstructionProfileCheckbox,"Instruction Profile Checkbox",index,testId);
			
			if (instructionType) {
				if (!AdditionalInformationTestData.get("Asset_Name").isEmpty())
					AddInfoSearchAssetType(indexInstructionProfile,testId);
				String fundPercentageString = AdditionalInformationTestData.get("Percentage").toString();
				System.out.println("Fund Percentage String : "+ fundPercentageString);
				String[] fundPercentageStringArray = fundPercentageString.split(",");
				System.out.println("Fund Percentage Length : "+ fundPercentageStringArray.length);
				for (j=0;j<fundPercentageStringArray.length;j++) {
					System.out.println("Fund Percentage : "+ fundPercentageStringArray[j]);
					CommonFunction.EnterValuesInTableByIndex(AssetTable,DisinvestmentPercentage,fundPercentageStringArray[j],"Fund Percentage ",indexInstructionProfile,j);
				}
			}		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
		
		private void AddInfoSearchAssetType(int assetIndex, String testId) throws Exception {
			// TODO Auto-generated method stub
			//System.out.println("Search Asset Type");
			//System.out.println("NewSheetTestData.get(AssetID) : " + NewSheetTestData.get("AssetID"));
			String fundNameString = AdditionalInformationTestData.get("Asset_Name").toString();
			String[] fundNameStringArray = fundNameString.split(",");
			for (j=0;j<fundNameStringArray.length;j++) {
				System.out.println("Fund Percentage : "+ fundNameStringArray[j]);
				CommonFunction.EnterValueByIndex(addinfofundsearchcriteriamanual,fundNameStringArray[j],"Search Asset ",assetIndex,testId);
				//CommonFunction.EnterValueByIndex(addinfofundsearchcriteriamanual,NewSheetTestData.get("AssetID"),"Search Asset ",assetIndex,testId);
				CommonFunction.ClickOnButtonByIndex(addinfofundsearchaction,"Click on search button of asset search ", assetIndex,testId);
				//CommonFunction.waitTillObjectExist(plusbtnofassetsearch);
				Thread.sleep(1000);
				//CommonFunction.clickByIndex("Plus Sign on Asset Search Screen ", plusbtnofassetsearch,assetIndex);
				CommonFunction.CheckValueByIndexXpath(addinfoplusbtnofassetsearch, "Plus Sign on Asset Search Screen ", assetIndex,testId);
				//System.out.println("Plus Sign");
				//click("Close button on asset search screen", assetclosebutton);
				CommonFunction.ClickOnButtonByIndex(addinfoassetclosebutton, "Close button on asset search screenn ", assetIndex,testId);
				//click("Close button on asset search screen", assetclosebutton);
				Thread.sleep(1000);
			}

		}		
}
