
print("\\Clear");

closeAllImages();
ResetROImanager();
run("Clear Results");

dir = getDirectory("Choose a Directory ");

getDateAndTime(year, month, dayOfWeek, dayOfMonth, hour, minute, second, msec);
MonthNames = newArray("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");
DayNames = newArray("Sun", "Mon","Tue","Wed","Thu","Fri","Sat");
if (hour<10) {hours = "0"+hour;}
else {hours=hour;}
if (minute<10) {minutes = "0"+minute;}
else {minutes=minute;}
if (month<10) {months = "0"+(month+1);}
else {months=month+1;}
if (dayOfMonth<10) {dayOfMonths = "0"+dayOfMonth;}
else {dayOfMonths=dayOfMonth;}

var Folder = 0;
results_Dir = dir + "Results "+year+"-"+months+"-"+dayOfMonths+" "+hours+"h"+minutes+ File.separator;
File.makeDirectory(results_Dir);

listDir = getFileList(dir);
var s = 0;
for (i = 0; i < listDir.length; i++) {
	Name=newArray(listDir.length);	
	if (endsWith(listDir[i],".jpg")) {
		open(dir + listDir[i]);
		name = getTitle;
		Name[i] = substring(name,0,lengthOf(name)-0);

		run("Colour Deconvolution", "vectors=H&E");
		selectWindow(Name[i]+"-(Colour_2)");
	run("Threshold...");
	waitForUser("Select droplet","Select droplet");
	run("Create Selection");

run("Analyze Particles...", "summarize");

saveAs("Results", results_Dir + "results_ORO_raw"+ Name[i] + ".xls");

	selectWindow(name);
	run("Duplicate...", " ");

	run("8-bit");
	run("Set Measurements...", "area mean standard display redirect=None decimal=5");
	run("Threshold...");
	waitForUser("Normlization on hemalun","Select hemalun area");
		run("Create Selection");
		run("Measure");
	closeAllImages();

saveAs("Results", results_Dir + "results_HE_raw" + ".xls");

}
} 

ResetROImanager();
closeAllImages();


///////////////// FUNCTIONS ////////////////////

function closeAllImages() {				
	while (nImages>0) {
		selectImage(nImages);
		close(); }
}


function newFolder() {					
	File.makeDirectory(Folder);
	listFolder = getFileList(Folder);
	for (i = 0; i < listFolder.length; i++) {
		File.delete(Folder+listFolder[i]); }
}

function prepareImage () {				
	s=getTitle;
	run("8-bit");
	run("Grays");
	return s;
}

function Liverselection() {				
	run("ROI Manager...");
	setTool("freehand");
	waitForUser("liver selection","Select liver new area\nbefore you click on OK");
	roiManager("Add");
	name=getTitle();
	Name=substring(name,0,lengthOf(name)-9);
	roiManager("Save", LiverROI_Dir + Name + ".zip");
	close();
	roiManager("reset");

}

function ResetROImanager() {				
run("ROI Manager...");
roiManager("reset");
}
		