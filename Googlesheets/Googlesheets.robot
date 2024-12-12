
*** Settings ***
Documentation    VERIFYING GOOGLE SHEETS DATA WITH INPUT FORM DATA
...
...              This document contains series of keywords
...              designed to verify that form data entered into a web form
...              has been correctly inserted into a Google Spreadsheet.
...
...              The script requires the following Robot Framework libraries:
...                 >>> Collections
...                 >>> RPA.Cloud.Google (for interacting with Google Sheets)
...
...              !!!Before using the Google Sheets library: !!!
...                 >>> The Google Sheets API must be enabled in the Google Cloud Console.
...                 >>> The specific Google Sheets document must have the appropriate permission,
...                 >>> including sharing the document with the service account used for authentication.
...
...              Variable  ${SPREADSHEET_ID} is obtained from the URL address of the Google Sheet:
...                 >>> it is located between /d/ and /edit in the URL
...              Variable  ${SHEET_NAME} is the name of the sheet - e.g. Sheet1 (!!!not the spreadsheet name!!!)
...              Variable  ${JSON_SERVICEACCOUNT} contains the path to the JSON service account file
...                 >>> serviceaccount.json file is obtained when creating a service account in the Google Cloud Console
...                 >>> make sure to add the path: Path From Repository Root



Library    Collections
Library    RPA.Cloud.Google


*** Variables ***
${SPREADSHEET_ID}         spreadshead_id
${SHEET_NAME}             sheet_name
${JSON_SERVICEACCOUNT}    path_to_serviceaccount.json_file

${FORM_VALID_NAME}        valid_name
${FORM_VALID_SURNAME}     valid_surname
${FORM_VALID_ADDRESS}     valid_adress
${FORM_VALID_PHONE}       valid_phone



*** Test Cases ***
Verify Data Insertion In Google Sheets
    Compare Form Data With Last Row in Google Sheet   ${FORM_VALID_NAME}
    ...                                               ${FORM_VALID_SURNAME}
    ...                                               ${FORM_VALID_ADDRESS}
    ...                                               ${FORM_VALID_PHONE}



*** Keywords ***

Compare Form Data With Last Row in Google Sheet
    [Documentation]     Compares the input form data with the data in Google Sheets
    ...                 to ensure that the data entered in the form was correctly transferred.
    [Arguments]         ${form_name}       ${form_surname}      ${form_adress}      ${form_phone}

    ${form_data_list}                      Create list        ${form_name}
    ...                                                       ${form_surname}
    ...                                                       ${form_adress}
    ...                                                       ${form_phone}
    ${last_row}                            Get Last Row from Google Sheet
    Compare Form and Last Row As A List    ${last_row}        ${form_data_list}


Compare Form and Last Row As A List
    [Documentation]          Comparing the form input data with the last row from a Google Spreadsheet as lists.
    ...                      It strips whitespace from the values
    ...                      and converts them to strings before the comparison.
    [Arguments]              ${last_row}    ${form_input_data}

    ${form_input_data}       Evaluate       [str(x).strip() for x in ${form_input_data}]
    ${last_row}              Evaluate       [str(x).strip() for x in ${last_row}]
    Lists Should Be Equal    ${last_row}    ${form_input_data}



Get Last Row from Google Sheet
    [Documentation]         Gets the last row of data from a specified Google Sheet,
    ...                     including initialization, data extraction, and selection of the last row.
    Init Sheets             ${JSON_SERVICEACCOUNT}
    ${data}                 Get All Sheet Values       ${SPREADSHEET_ID}
    ${rows}                 Get From Dictionary        ${data}              values
    ${last_row}             Get Last Row               ${rows}
    [Return]                ${last_row}


Get Last Row
    [Documentation]         Gets Last Row from a list of rows.(-1 parameter selects the last element from the list)
    [Arguments]             ${rows}
    ${last_row}             Get From List              ${rows}        -1
    Log                     ${last_row}
    [Return]                ${last_row}

