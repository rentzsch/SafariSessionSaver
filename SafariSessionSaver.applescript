current_safari_session()

on current_safari_session()
	tell application "Safari"
		set urlList to {}
		set windowList to every window
		repeat with windowIt in windowList
			try
				set tabList to every tab of windowIt
				repeat with tabIt in tabList
					set urlList to urlList & URL of tabIt
				end repeat
			end try
		end repeat
	end tell
	
	-- AppleScript list => tab-delimited text.
	set oldTextItemDelimiters to AppleScript's text item delimiters
	set AppleScript's text item delimiters to tab
	set urlList to urlList as text
	set AppleScript's text item delimiters to oldTextItemDelimiters
	
	return urlList
end current_safari_session

on restore_safari_session(urlList)
	ignoring application responses
		tell application "Safari"
			repeat with urlIt in paragraphs of urlList
				make new document at end of documents with properties {URL:urlIt}
			end repeat
		end tell
	end ignoring
end restore_safari_session
