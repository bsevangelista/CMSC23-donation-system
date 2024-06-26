﻿# ELBIdonate

## Group Details
- Aboga, Trisha Angeline R. (traboga@up.edu.ph)
- Cutines, Adrian Carl B. (abcutines@up.edu.ph)
- Evangelista, Biarritz Alain S. (bsevangelista@up.edu.ph)

## Program Description
ELBIdonate is a donation management app designed to connect donors with organizations in need. The app facilitates the donation process by allowing users to sign up as either donors or organizations that accept donations. Donors can browse through a list of organizations, choose items to donate, and specify pickup or drop-off details. Organizations can manage donations, update their status, and showcase donation drives. Admins oversee the approval of organizations and monitor all activities.

### Steps to Install

1. Clone the repository from GitHub.
git clone https://github.com/bsevangelista/CMSC23-donation-system.git
2. Navigate to the project directory.
3. Install the required dependencies.
flutter pub get
4. Set up Firebase:
- Create a Firebase project.
- Enable Firestore and Authentication.
- Add your Firebase configuration to the project. 
5. Run the app on an emulator or connected device.
flutter run
6. Building the APK
- To build the APK for installation on devices, run the following command:
flutter build apk
- The APK file will be generated in the build/app/outputs/flutter-apk directory.

## User Guide for the ELBIdonate
Welcome to ELBIdonate! This guide will help you navigate through the app’s various features and screens. Follow the instructions below to make the most out of your experience, whether you are a donor, an organization, or an admin.

### User’s View

#### Sign In (Authentication)
1. Open the app.
2. Tap on the "Sign In" button.
3. Enter your username and password.
4. Tap "Sign In" to access your account.

#### Sign Up
1. Open the app.
2. Tap on the "Sign Up" button.
3. Fill in the required fields: Name, Username, Password, Address(es), and Contact No.
4. If you want to sign up as an organization that accepts donations, select the option for organization sign-up.
   - Enter the Name of the organization.
   - Upload Proof(s) of legitimacy (e.g., registration documents).
5. Submit the sign-up form.
6. Wait for approval if signed up as an organization. Donors are automatically signed up.

### Donors’ View

#### Homepage
1. After signing in, you will see a list of organizations where you can send your donations.

#### Donate
1. Tap on an organization from the homepage list.
2. Fill in the following information:
   - Select donation item category (e.g., Food, Clothes, Cash, Necessities, Others).
   - Choose if the items are for pickup or drop-off.
   - Enter the weight of the items in kg/lbs.
   - (Optional) Upload a photo of the items using your phone camera.
   - Choose the date and time for pickup/drop-off.
   - Enter the address for pickup (you can save multiple addresses).
   - Provide a contact number for pickup.
3. If the item is for drop-off:
   - Generate a QR code by tapping on the "Generate QR Code" button.
   - The organization will scan this QR code to update the donation status.
4. You can cancel the donation if needed by tapping the "Cancel Donation" button.

#### Profile
1. Access your profile by tapping on your profile icon.
2. View personal information and donation history.

### Organization’s View

#### Homepage
1. After signing in, you will see a list of all donations.

#### Donation
1. Tap on a donation to view its details.
2. Update the status of each donation as needed:
   - Pending
   - Confirmed
   - Scheduled for Pick-up
   - Complete
   - Canceled

#### Donation Drives
1. Tap on the "Donation Drives" section.
2. View, create, update, or delete donation drives.
3. Link donations to specific donation drives.
4. Upload photos as proof of where the donations ended up.

#### Profile
1. Access your profile by tapping on your profile icon.
2. View and edit your organization’s information:
   - Organization Name
   - About the organization
   - Status for donations (open or close)

### Admin’s View

#### Sign In (Authentication)
1. Open the app.
2. Tap on the "Sign In" button.
3. Enter your admin username and password.
4. Tap "Sign In" to access the admin panel.

#### View All Organizations and Donations
1. After signing in, you will see a dashboard with all organizations and donations listed.

#### Approve Organization Sign Up
1. Go to the Organizations section.
2. Review the details and proof of legitimacy for each organization sign-up request.
3. Approve the sign-up request as necessary.

#### View All Donors
1. Access the list of all registered donors from the admin dashboard.
