on current_safari_session()
	tell application "Safari" to set urlList to URL of every document
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
