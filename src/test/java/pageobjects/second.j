package com.pru.pageobjects;

import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;

import com.pru.utilities.CommonFunction;
import com.pru.utilities.ExtentReport;
import com.pru.utilities.PageInitiator;
import com.pru.utilities.TestBase;
import com.pru.utilities.TestDataProvider;

public class PruWealth_AssetSelectionPage extends PageInitiator {
	
	@FindBy(css="input[id*='fundSearchCriteriaManual']")
	private static WebElement fundsearchcriteriamanual;
	@FindBy(css="button[id*='fundSearchAction']")
	private static WebElement fundsearchaction;
	@FindBy(css="button[id*='modelPortfolioSearchAction']")
	private static WebElement modelportfoliosearchaction;
	@FindBy(css="tr input[id*=lumpSumPercentage]")
	private static WebElement lumpsumpercentage;
	@FindBy(css="input[id*='regularPercentage']")
	private static WebElement regularpercentage;	
	@FindBy(css="input[id*='transferPercentage']")
	private static WebElement transferpercentage;
	@FindBy(css="select[id*='fundSearchType']")
	private static WebElement fundsearchtype;	
	@FindBy(css="input[id*='modelPortfolioSearchCriteria']")
	private static WebElement modelportfoliosearchcriteria;
	@FindBy(css="button[id='modelPortfolioSearchForm:modelPortfolioSearchResults:0:selectModelPortfolioAcion']")
	private static WebElement modelportfoliosearchbutton;
	@FindBy(css="button[id='nextAction']")
	private static WebElement assetselectionnextbutton;
	@FindBy(css="select[id*='gteeName']")
	private static WebElement selectguarantee;	
	@FindBy(css="input[id*='lumpSumGteePercentage']")
	private static WebElement lumpsumgteepercentage;	
	@FindBy(css="input[id*='regularGteePercentage']")
	private static WebElement regulargteepercentage;
	@FindBy(css="input[id*='transferGteePercentage']")
	private static WebElement transfergteepercentage;
	@FindBy(css="input[id*='_input']")
	private static WebElement gteeenddate;
	//@FindBy(css="td > button")
	@FindBy(css="button[id*='group:j_idt1'][class*='ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only image-button add-button']")
	private static WebElement plusbtnofassetsearch;
	@FindBy(css="button[id*='group:fundSearchDialogOkAction'][class*='ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only']")
	private static WebElement assetclosebutton;
	@FindBy(css="button[id='nextAction']")
	private static WebElement AseetSelectionNextButton;
	@FindBy(css="table[id*='group:splits']")
	private static WebElement AseetSelectiontables;
	@FindBy(css="tr table span[id*=fundName]")
	private static WebElement AseetSelectionRows;
	@FindBy(xpath="//h2[text()='Income and Withdrawals']")
	private WebElement verifyincomewithdrawalpage;
	@FindBy(xpath="//h2[text()='Additional information']")
	private WebElement verifyadditionalinformationpage;
	@FindBy(css="input[id*='cashHoldingCoverageCheck']")
	private WebElement cashHoldingCoverageCheckBox;

	@FindBy(css="span.ui-messages-error-summary")
	private WebElement errorMessage;
		
	
	
	public void AssetSelection (String testId) throws Throwable {
		
		//System.out.println("Inside Asset Selection Page");	
		
		int noOfComponents,noOfLines;
		int AssetIndex = 0 ;
		int GteeIndex = 0;
		int SingleGteeIndex = 0;
		int RegularGteeIndex = 0;
		int TransferGteeIndex = 0;
		int GteeListBoxIndex = 0 ;
		int intFlag = 0;
		
		//Thread.sleep(2000);
		noOfLines= TestDataProvider.getTestCaseCountFromSheet("AccountDetailsPage",testId);
		//System.out.println("noOfLines " + noOfLines);
		int intRowNumber = TestDataProvider.getRowNumber("AccountDetailsPage", testId);
		System.out.println("intRowNumber : " + intRowNumber);		
		for (int i=1;i<noOfLines+1;i++){
			NewSheetTestData = TestDataProvider.testsheet_DetailedInformation("AccountDetailsPage", testId, intRowNumber);
			if((NewSheetTestData.get("Accout_Type").equalsIgnoreCase("Pension Savings")) && (NewSheetTestData.get("AccountOption_IncomeAndWithdrawals").equalsIgnoreCase("Y"))){
				System.out.println("inside");
				CommonFunction.CheckValueByIndex(cashHoldingCoverageCheckBox,"Automatically set cash holding",intFlag,testId);
				intFlag ++;
				int Count = CommonFunction.GetLocatorCount(cashHoldingCoverageCheckBox,testId);
				System.out.println("Count : " + Count);
				intRowNumber++;
			}					
		}


		noOfComponents = TestDataProvider.getTestCaseCountFromSheet("AssetSelection",testId);
		//System.out.println("noOfComponents " + noOfComponents);
		int rowNumber = TestDataProvider.getRowNumber("AssetSelection", testId);
		NewSheetTestData = TestDataProvider.testsheet_DetailedInformation("AssetSelection", testId, rowNumber);
		String AssetType = NewSheetTestData.get("AssetType");
		System.out.println("AssetType : "+ AssetType);	
		for(int i=1;i<noOfComponents+1;i++){
			NewSheetTestData = TestDataProvider.testsheet_DetailedInformation("AssetSelection", testId, rowNumber);
			
			//System.out.println("NewSheetTestData.get(AssetType) : "+ NewSheetTestData.get("AssetType"));	
			
			if(!NewSheetTestData.get("AssetType").equalsIgnoreCase(AssetType)){
				AssetType = NewSheetTestData.get("AssetType");
				AssetIndex = AssetIndex +1;
			}
					
		
			if(NewSheetTestData.get("Asset").equalsIgnoreCase("Cash")){
				System.out.println("Cash : "+ NewSheetTestData.get("Asset"));
				EnterCashPercentages(AssetIndex);
			}
			if(NewSheetTestData.get("Asset").equalsIgnoreCase("Fund")){
				//System.out.println("Fund : "+ NewSheetTestData.get("Asset"));
				if(!NewSheetTestData.get("AssetID").equalsIgnoreCase(null)){
					SearchAssetType(AssetIndex,testId);
					EnterFundPercentages(AssetIndex);				
				}
			}
			if(NewSheetTestData.get("Asset").equalsIgnoreCase("Model Portfolio Search")){
				System.out.println("Fund : "+ NewSheetTestData.get("Asset"));
				if(!NewSheetTestData.get("AssetID").equalsIgnoreCase(null)){
					SearchModelPortfilio(AssetIndex,testId);
					EnterFundPercentages(AssetIndex);				
				}
			}
			
			if(GteeIndex > 0 && !NewSheetTestData.get("Asset").equals("Gtee")){
				//System.out.println("GteeListBoxIndex : " +GteeListBoxIndex);
				GteeListBoxIndex++;
			}
				
			if(NewSheetTestData.get("Gtee").equalsIgnoreCase("Yes")){
				System.out.println("GteeListBoxIndex: " + GteeListBoxIndex + " NewSheetTestData.get(Asset) :" + NewSheetTestData.get("Asset"));
				int tblRowNumber = CommonFunction.getTableRowValueOfGteeByIndex(AseetSelectiontables,selectguarantee,"Select guarantee",AssetIndex);
				System.out.println("tblRowNumber : " + tblRowNumber);
				CommonFunction.SelectValueInTableByIndex(AseetSelectiontables,selectguarantee,NewSheetTestData.get("GteeValue"),"Select Guarantee from list  ",AssetIndex,tblRowNumber,testId);
				//CommonFunction.SelectValueByIndex(selectguarantee,NewSheetTestData.get("GteeValue"),"Select Guarantee from list  ",GteeListBoxIndex);
				
				Thread.sleep(1000);
				FilllGuaranteeAssetPercentages(SingleGteeIndex,RegularGteeIndex,TransferGteeIndex,testId);	
				GteeIndex++;
				if(!NewSheetTestData.get("GteeSinglePer").equals(null) && ((NewSheetTestData.get("GteeSinglePer").length()!=0)))
					SingleGteeIndex++;
				if(!NewSheetTestData.get("GteeRegularPer").equals(null) && ((NewSheetTestData.get("GteeRegularPer").length()!=0)))
					RegularGteeIndex++;
				if(!NewSheetTestData.get("GteeTransferPer").equals(null) && ((NewSheetTestData.get("GteeTransferPer").length()!=0)))
					TransferGteeIndex++;			
			}
			rowNumber++;			
		}
		
		click("Click on Next Button from Asset Selection Page : ", AseetSelectionNextButton, testId);
		
/*		try{
			if(errorMessage.isDisplayed()){
				System.out.println("Error Message dispalyed syso: " + errorMessage.getText());
				ExtentReport.reportFail("Asset Selection : Error Message dispalyed : " + errorMessage.getText(),testId);
			}
		} catch(Exception e){}*/
		
		if(TestData("IncomeAndWithdrawalsPage").equalsIgnoreCase("Y")){
			//System.out.println("Transfers");
			CommonFunction.waitTillObjectNotExist(verifyincomewithdrawalpage,testId);
			if(TestBase.verifyElementDisplayed("Income and Withdrawal Page" , verifyincomewithdrawalpage, testId ))
				ExtentReport.reportPass("Income and Withdrawal Page successfully displayed");
		}else{
			//System.out.println("Contribution");
			CommonFunction.waitTillObjectNotExist(verifyadditionalinformationpage,testId);
			if(TestBase.verifyElementDisplayed("Additional Informaion Page " , verifyadditionalinformationpage, testId));
				ExtentReport.reportPass("Additional Informaion Page successfully displayed");			
		}		
	}

	private static void FilllGuaranteeAssetPercentages(int singleIndex,int regularGteeIndex, int transferGteeIndex, String testId) throws Exception {
		// TODO Auto-generated method stub
		if(!NewSheetTestData.get("GteeSinglePer").equals(null) && ((NewSheetTestData.get("GteeSinglePer").length()!=0)))
			CommonFunction.EnterValueByIndex(lumpsumgteepercentage,NewSheetTestData.get("GteeSinglePer"),"Guarantee Single Percentage ",singleIndex,testId);
		if(!NewSheetTestData.get("GteeRegularPer").equals(null) && ((NewSheetTestData.get("GteeRegularPer").length()!=0)))
			CommonFunction.EnterValueByIndex(regulargteepercentage,NewSheetTestData.get("GteeRegularPer"),"Guarantee Regular Percentage ",regularGteeIndex,testId);
		if(!NewSheetTestData.get("GteeTransferPer").equals(null) && ((NewSheetTestData.get("GteeTransferPer").length()!=0)))
			CommonFunction.EnterValueByIndex(transfergteepercentage,NewSheetTestData.get("GteeTransferPer"),"Guarantee Transfer Percentage ",transferGteeIndex,testId);
	}

	private static void EnterFundPercentages(int index) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("EnterFundPercentages : " +index);
		String asstValue = NewSheetTestData.get("AssetName");
		int rowNumber = CommonFunction.getTableRowValueByIndex(AseetSelectiontables,AseetSelectionRows,asstValue,index);
		
		System.out.println("rowNumber : " + rowNumber);
		
		if(!NewSheetTestData.get("FundSinglePer").equals(null) && (!(NewSheetTestData.get("FundSinglePer").length()==0))){
			System.out.println("FundSinglePer : "+ NewSheetTestData.get("FundSinglePer"));				
			CommonFunction.EnterValuesInTableByIndex(AseetSelectiontables,lumpsumpercentage,NewSheetTestData.get("FundSinglePer"),"Fund Single Percentage ",index,rowNumber);
			//CommonFunction.EnterValueByIndex(lumpsumpercentage,NewSheetTestData.get("FundSinglePer"),"Fund Single Percentage ",index);
		}	
		if(!NewSheetTestData.get("FundRegularPer").equals(null) && (!(NewSheetTestData.get("FundRegularPer").length()==0))){
			//System.out.println("FundRegularPer : "+ NewSheetTestData.get("FundRegularPer"));
			//System.out.println("FundRegularPer Length : "+ NewSheetTestData.get("FundRegularPer").length());				
			CommonFunction.EnterValuesInTableByIndex(AseetSelectiontables,regularpercentage,NewSheetTestData.get("FundRegularPer"),"Fund Regular Percentage ",index,rowNumber);

			//CommonFunction.EnterValueByIndex(regularpercentage,NewSheetTestData.get("FundRegularPer"),"Fund Regular Percentage ",index);
		}			
		if(!NewSheetTestData.get("FundTransferPer").equals(null) && (!(NewSheetTestData.get("FundTransferPer").length()==0))){
			System.out.println("FundTransferPer : "+ NewSheetTestData.get("FundTransferPer"));				
			CommonFunction.EnterValuesInTableByIndex(AseetSelectiontables,transferpercentage,NewSheetTestData.get("FundTransferPer"),"Fund Transfer Percentage ",index,rowNumber);

			//CommonFunction.EnterValueByIndex(transferpercentage,NewSheetTestData.get("FundTransferPer"),"Fund Transfer Percentage ",index);
		}
			
	}

	private static void EnterCashPercentages(int index) throws Exception {
		// TODO Auto-generated method stub
		int rowNumber = CommonFunction.getTableRowValueByIndex(AseetSelectiontables,AseetSelectionRows,"Cash",index);
		//System.out.println("rowNumber :" + rowNumber);
		
		if(!NewSheetTestData.get("CashSinglePer").equals(null) && (!(NewSheetTestData.get("CashSinglePer").length()==0))){
			//System.out.println("CashSinglePer : "+ NewSheetTestData.get("CashSinglePer"));
			scrollintoview(lumpsumpercentage);				
			CommonFunction.EnterValuesInTableByIndex(AseetSelectiontables,lumpsumpercentage,NewSheetTestData.get("CashSinglePer"),"Fund Single Percentage ",index,rowNumber);
	
			//CommonFunction.EnterValueByIndex(lumpsumpercentage,NewSheetTestData.get("CashSinglePer"),"Cash Single Percentage ",index);
		}		
		if(!NewSheetTestData.get("CashRegularPer").equals(null) && (!(NewSheetTestData.get("CashRegularPer").length()==0))){
			//System.out.println("CashRegularPer : "+ NewSheetTestData.get("CashRegularPer"));
			//System.out.println("CashRegularPer Length : "+ NewSheetTestData.get("CashRegularPer").length());
			scrollintoview(regularpercentage);
			CommonFunction.EnterValuesInTableByIndex(AseetSelectiontables,regularpercentage,NewSheetTestData.get("CashRegularPer"),"Fund Regular Percentage ",index,rowNumber);

			//CommonFunction.EnterValueByIndex(regularpercentage,NewSheetTestData.get("CashRegularPer"),"Cash Regular Percentage ",index);
		}
		if(!NewSheetTestData.get("CashTransferPer").equals(null) && (!(NewSheetTestData.get("CashTransferPer").length()==0))){
			//System.out.println("CashTransferPer : "+ NewSheetTestData.get("CashTransferPer"));
			scrollintoview(transferpercentage);
			CommonFunction.EnterValuesInTableByIndex(AseetSelectiontables,transferpercentage,NewSheetTestData.get("CashTransferPer"),"Fund Transfer Percentage ",index,rowNumber);
			//CommonFunction.EnterValueByIndex(transferpercentage,NewSheetTestData.get("CashTransferPer"),"Cash Transfer Percentage ",index);
		}
			
	}
	

	private static void SearchAssetType(int assetIndex, String testId) throws Exception {
		// TODO Auto-generated method stub
		//System.out.println("Search Asset Type");
		//System.out.println("NewSheetTestData.get(AssetID) : " + NewSheetTestData.get("AssetID"));
		CommonFunction.EnterValueByIndex(fundsearchcriteriamanual,NewSheetTestData.get("AssetID"),"Search Asset ",assetIndex,testId);
		CommonFunction.ClickOnButtonByIndex(fundsearchaction,"Click on search button of asset search ", assetIndex,testId);
		//CommonFunction.waitTillObjectExist(plusbtnofassetsearch);
		Thread.sleep(1000);
		//CommonFunction.clickByIndex("Plus Sign on Asset Search Screen ", plusbtnofassetsearch,assetIndex);
		CommonFunction.CheckValueByIndexXpath(plusbtnofassetsearch, "Plus Sign on Asset Search Screen ", assetIndex,testId);
		//System.out.println("Plus Sign");
		//click("Close button on asset search screen", assetclosebutton);
		CommonFunction.ClickOnButtonByIndex(assetclosebutton, "Close button on asset search screenn ", assetIndex,testId);
		//click("Close button on asset search screen", assetclosebutton);
		Thread.sleep(2000);
	}

	private void SearchModelPortfilio(int assetIndex, String testId) throws Exception {
		// TODO Auto-generated method stub
		CommonFunction.SelectValueByIndex(fundsearchtype, NewSheetTestData.get("Asset"), "Model Portfolio ", assetIndex, testId);
		Thread.sleep(1000);
		CommonFunction.EnterValueByIndex(modelportfoliosearchcriteria,NewSheetTestData.get("AssetID"),"Search Model Portfolio Asset ",assetIndex,testId);
		CommonFunction.ClickOnButtonByIndex(modelportfoliosearchaction,"Click on search button of model portfolio asset search ", assetIndex,testId);
		//CommonFunction.waitTillObjectExist(plusbtnofassetsearch);
		Thread.sleep(1000);
		CommonFunction.ClickOnButtonByIndex(modelportfoliosearchbutton, "Search button on model portfolio asset search screenn ", assetIndex,testId);
		Thread.sleep(2000);	
		System.out.println("Model Portfolio");
	}
}
