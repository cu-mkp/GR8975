import httplib2
import os
from apiclient import errors
import apiclient.http
from apiclient import discovery
from apiclient import http
import oauth2client
from oauth2client import client
from oauth2client import tools
from oauth2client.client import OAuth2WebServerFlow
import json
import time
from threading import Thread
import sys
import csv
import io
from apiclient.http import MediaIoBaseDownload
import urllib
from oauth2client.service_account import ServiceAccountCredentials
from httplib2 import Http
import json
from docx import opendocx, getdocumenttext

from datetime import datetime, timedelta

try:
    import argparse
    flags = argparse.ArgumentParser(parents=[tools.argparser]).parse_args()
except ImportError:
    flags = None

def document_to_text(filename,file_path):
	print("inside doctotxt")
	document = opendocx(file_path+filename+".docx")
	paratextlist = getdocumenttext(document)
	newparatextlist = []
	for paratext in paratextlist:
		newparatextlist.append(paratext.encode("utf-8"))
	os.remove(file_path+filename+".docx")
	return '\n\n'.join(newparatextlist)

def downloadFile(filename,file_id,mimeType,service,foldName):
	''' Downloads the files to the local directory.The directory structure is preserved and so are the documents' comments.
	The local directory where the download takes place is the directory where the script is currently running'''
	print("Downloading -- " + filename)
	try:
		request = service.files().get_media(fileId=file_id)
		newpath="./"+foldName
		if not os.path.exists(newpath):
			os.makedirs(newpath)
	except Exception as error:
		    			target = open("FiletoDownloadManually.txt", 'a');
		    			target.write(str(error));
		    			target.write("\n");
		    			print('An error occurred: %s' % error);

	try:
		if "application/vnd.google-apps" in mimeType:
			if "document" in mimeType:
				#request = service.files().export_media(fileId=file_id, mimeType='application/vnd.openxmlformats-officedocument.wordprocessingml.document')
				#if ".docx" not in file_name:
				#	file_name = file_name + ".docx"
				url="https://docs.google.com/document/d/"+file_id+"/export?format=doc"
				url=url.encode('utf-8');
				if filename.startswith("tl"):
					urllib.urlretrieve (url, "./"+foldName+"/"+filename+".docx");
					response=document_to_text(filename,"./"+foldName+"/");
					print(len(response))
					if not os.path.exists(newpath):
						print("inside if")
						os.makedirs(newpath)
					with open(os.path.join(newpath+"/", filename+".txt"), "wb") as wer:
						print("inside with")
						wer.write(response)
		
			'''elif "presentation" in mimeType:
				url="https://docs.google.com/presentation/d/"+file_id+"/export/pptx"
				urllib.urlretrieve (url, "./"+foldName+"/"+filename+".pptx");
		
			elif "spreadsheet" in mimeType:
				url="https://docs.google.com/spreadsheets/d/"+file_id+"/export?format=xlsx"
				urllib.urlretrieve (url, "./"+foldName+"/"+filename+".xlsx");
			elif "pdf" in mimeType:
				request = service.files().export_media(fileId=file_id, mimeType='application/pdf')
				file_name = filename + ".pdf"
				response = request.execute()
				newpath = "./"+foldName
				if not os.path.exists(newpath):
					os.makedirs(newpath)
				with open(os.path.join(newpath+"/", file_name), "wb") as wer:
					wer.write(response)'''

		'''else:
			response = request.execute()
			newpath = "./"+foldName
			if not os.path.exists(newpath):
				os.makedirs(newpath)
			with open(os.path.join(newpath+"/", filename), "wb") as wer:
				wer.write(response)'''

	except Exception as error:
		    			target = open("FiletoDownloadManually.txt", 'a');
		    			target.write(str(error));
		    			target.write("\n");
		    			print('An error occurred: %s' % error);

def filesInFolder(service,foldId,foldName,lastupdated):
	''' Returns the files and subfolders inside a given directory.
		Takes the google drive service object and folder ID (foldId),folder name(foldName) and lastupdated(when the file was lastupdated) as the inputs
		and returns all the files inside that folder.It calls the download function(downloadFile) that backs up the files and folders'''
	page_token = None;
	print "*********"
	print "inside filesInFolder"
	while True:
		try:
		    param = {}
		    string ="'"+str(foldId)+"' in parents"
		    if page_token:
		        param['pageToken'] = page_token
		    children = service.files().list(q=string,fields='files(modifiedTime,id,mimeType,name)',pageSize=500, **param).execute()
		    
		    for x,v in children.iteritems():
		    	for subval in v:
		    		try:
		    			print"----------"
		    			print ("name: "+ subval['name']);
		    			print ("modifiedTime: "+subval['modifiedTime']);
		    			
		    			print ("mimeType "+subval['mimeType']);
		    			#check if the file/folder is being downloaded for the first time or not"
		    			if lastupdated!=0:
		    				
		    				if "/" in subval['name']:
		    					print("error")
		    					i=subval["name"].index("/")
		    					filenamefordownload=subval["name"][0:i]+'_'+subval["name"][i+1:len(subval["name"])];
		    				else:
		    					filenamefordownload=subval["name"];
		    				if(subval['modifiedTime']>=lastupdated):
		    					downloadFile(filenamefordownload,subval["id"],subval["mimeType"],service,foldName)
		    				
		    				print "-----------"
		    			else:
		    				if "/" in subval['name']:
		    					print("File name contains /")
		    					i=subval["name"].index("/")
		    					filenamefordownload=subval["name"][0:i]+'_'+subval["name"][i+1:len(subval["name"])];
		    				else:
		    					filenamefordownload=subval["name"];
		    				downloadFile(filenamefordownload,subval["id"],subval["mimeType"],service,foldName);

		    				print "-----------"
		    		except Exception as error:
		    			target = open("FiletoDownloadManually.txt", 'a');
		    			target.write(str(error));
		    			target.write("\n");
		    			print('An error occurred: %s' % error);

		 
		        return v
		    if not page_token:
		        	break
		except Exception as error:
			target = open("FiletoDownloadManually.txt", 'a');
			target.write(str(error));
			target.write("\n");
			print('An error occurred: %s' % error);
		   






	

def getService(key,version):
	'''Takes the name of the privatekey to use for getting the credentials and
	 the version of the drive api to use and then sets up the service object 
	 and returns it to the user.'''
	scopes = ['https://www.googleapis.com/auth/drive']
	credentials = ServiceAccountCredentials.from_json_keyfile_name(key, scopes)
	http_auth = credentials.authorize(Http())
	service = discovery.build('drive', version, http=http_auth)
	return service

def main():
	
	service3 = getService('mkp-privatekey.json','v3')
	# The folder id of the BnF Ms Fr 640 is '0B42QaQPHLJloc3hDRWgyY2JCUVk'
	folderIdOfParentDirectory=raw_input("Enter folder id ");
	foldernameofParent=raw_input("Enter folder name ");
	firsttime=raw_input("Is this folder being backed up for the first time?(yes/no) ");
	
	if firsttime=="No" or firsttime=="no":
		
		st=datetime.now()+ timedelta(days=-8)
		
		lastupdated=st.strftime("%Y-%m-%dT%I:%M:%S");
	else:
		
		lastupdated=0
	
	print(lastupdated)
	folderSet=set();
	fileSet=set();
	d=();
	d=list(d)
	d.insert(0,folderIdOfParentDirectory)
	d.insert(1,foldernameofParent)
	
	d=tuple(d)
	folderSet.add(d)
	print("Starting to get the files at ",time.ctime(time.time()))
	'print(retrieve_all_files(service3,folderIdOfParentDirectory))'
	# Traverse through all the folders and sub-folders and all the files to a fileSet recursively.
	while(len(folderSet)>0):
		fold=folderSet.pop()
		print fold
		items=filesInFolder(service3,fold[0],fold[1],lastupdated)
		for x in items:
			if(x['mimeType'].endswith('folder')):
				d=();
				d=list(d);
				d.insert(0,x['id'])
				d.insert(1,fold[1]+"/"+x['name'])
				
				d=tuple(d)
				folderSet.add(d)
				
			else:
				fileSet.add(str(x['id']))
	print("Completed getting the files at ",time.ctime(time.time()))
	print("Number of files: ",len(fileSet))
	
	
    
    
if __name__ == '__main__':
	try:
		main()
	except Exception,e:
		print(e)
