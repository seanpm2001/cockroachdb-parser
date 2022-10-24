# extract_log_channels.awk builds a go file in package main with a
# map[string]struct{} containing entries corresponding to the members of the
# protobuf enum Channel.

BEGIN {
	inside_enum = 0
	print ("// Code generated by gen.go. DO NOT EDIT.\n")
	print ("package main\n")
	print ("var channels = map[string]struct{}{")
}

$0 ~ /^enum Channel \{/ {
	inside_enum = 1
}

inside_enum && $1 ~ /[A-Z]+/ {
	printf "\t\"%s\": {},\n", $1
}

inside_enum && $0 == "}" {
	print("}")
	inside_enum = 0
}

