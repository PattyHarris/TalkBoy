#  Upload to App Store Notes

This will describe steps discussed in the tutorial for pushing this app to the Store (which I'm not going to do)

Apple Certificate, ID, and Provisioning Profile

##  Apple Certificate

    1. Select, for pushing up to the Store, Production and App Store and Add Hoc.  Select Continue.
    
    2.  Then from the Mac, search for Keychain Access (CMD + Spacebar).  From the Keychain Access menu. select
    Certificate Assistant  - Request a certificate from a Certificate Authority.
    
    3. In the dialog that comes up, make sure "Save to disk" is selected.  Fill in the requested data - email address and the
    name you're known by in the Apple Store.  The CA Email Address is blank.  Click Continue and on the
    next screen of the dialog, click Save.
    
    4. Back in Safari, click Continue.
    
    5. Here' you'll upload the CSR that was just created.  Once you click "Done",  you will see an
    iOS Distribution Certificate.  You will need to download the final certificate in order to make
    it available in XCode - see below where you turn off "Automatic Signing Management" - you
    will need to add the .cer file here in XCode.  Double-click on the downloaded file to make
    it available to your XCode.

## ID

    1. The identifier uniquely identifies the app.
    
    2. Add an app description - in this case since Talkboy may be copyrighted (something about Home Alone),
    so use something else (like Simple Sound Recorder).  Nick wavered on this so it may be ok to use
    TalkBoy.
    
    3. The Bundle ID is from XCode - com.pharris.TalkBoy
    
    4. No App Services are needed for this app so click Continue and Register and Done.


## Provisioning Profile

    1. Contains your certificate and app ID.  It also is where you indicate what you want to do
    with your app.

    2. In this case, we're using Distribution for the App Store (so that option is selected).
    
    3. Enter your App ID and Certificated (just created for this distribution)

    4. The Provisioning Profile name - Talk Boy App Store - it should tell you what this provisioning
    is for.  It is not public facing.  Download the completed provisioning file.
    
    5. From the Downloads, double-click on the file - in this case, the file was named
    Talk_Boy_App_Store.mobileprovision
    
    6. Next, open up XCode - Preferences and Accounts - login with your Apple ID developer
    account.  Then, in the XCode project, Target, General, select the appropriate Team.
    
    7. Nick suggests that you uncheck "Automatic Signing" - he indicates this can created
    a lot of havoc.  When you do that, you're repsonsible for signing for debug and
    release - this just means selecting the Provisioning Profile that was downloaded.

##  Getting XCode Ready

    1. Nick set the deployment OS vesion to 10.3 (from 11, hmmmm)
    
    2. Set the Simulated Device to "Generic iOS Device"
    
    3. Under Product, select Archive to prepare the App for uploading to the store.  You may be asked
    if the user name used in the certificate can be used by the keychain - fine.
    
    4. From the Archives screen that shows, you can upload to the App Store - at this point it
    will fail since there's some iTunes Connect setup that still needed plush we may need
    icons for the app.
    
##  Setting up iTunes Connect

    1. iTunes Connect is where you manage all the meta data about your app.
    
    2. You can reach iTunes Connect from your account main page or go to itunesconnect.apple.com
    
    3. From there you click on MyApps.  It may ask you to sign some agreements or setup some
    banking.  If there are no apps, it will say "Click + to add an app"
    
    4. After you click +, the dialog will ask for the platform (iOS), name (Simple Voice Recorder),
    primary language, Bundle ID - in my case Simple Sound Recorder - com.pharris.TalkBoy.  It
    can really be anything ?  The SKU "can" really be anything - Nick types gibberish...I used
    an online encryption tool to generate the number based on "TalkBoy"
    
    
    5. And that's as far as we can go at this time until iOS 11 apps are accepted in the store.

    
    



