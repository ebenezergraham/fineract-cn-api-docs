#!/usr/bin/env bash

# Author Juhan Aasaru

print_endpoint() {
    echo ".curl-request"
    echo "include::{snippets}/$1/curl-request.adoc[]"
    echo ""
    echo ".http-request"
    echo "include::{snippets}/$1/http-request.adoc[]"
    echo ""
    echo ".httpie-request"
    echo "include::{snippets}/$1/httpie-request.adoc[]"
    echo ""
    echo ".request-fields"
    echo "include::{snippets}/$1/request-fields.adoc[]"
    echo ""
    echo ".http-response"
    echo "include::{snippets}/$1/http-response.adoc[]"
    echo ""
    echo "'''"
    echo ""
}
generate_adoc () {
    outputFilename=$2
    outputFolder="src/main/asciidoc/"
    outputFullPath="$outputFolder$outputFilename.adoc"
#    > "$outputFullPath"
    echo "" >> "$outputFullPath"

    for entry in "../fineract-cn-$2/component-test/build/doc/generated-snippets/$1"
    do
        folderName=${entry//\.\.\//}
        print_endpoint $folderName >> "$outputFullPath"
    done

    echo "<li><a href="$outputFilename.html">$outputFilename</a></li>" >> $indexFile
}

indexFile="src/main/resources/doc/html5/index.html"
echo "<h1>Fineract API documentation</h1><ul>" > "$indexFile"

#generate_adoc 'test-transaction-type' 'accounting'
#generate_adoc 'test-identification-cards' 'customer'
#generate_adoc 'test-deposit' 'deposit-account-management'
#generate_adoc 'test-group' 'group'
#generate_adoc 'test-identity' 'identity'
#generate_adoc 'test-payroll' 'payroll'
#generate_adoc 'test-teller' 'teller'
array=$(ls /home/ebenezergraham/apache/fineract-cn-notifications/component-test/build/doc/generated-snippets)
#Fineract CN API Documentation
    for dir in ${array[@]}; do
    echo $dir
        generate_adoc $dir 'notifications'
    done
echo "</ul><a href='https://github.com/aasaru/fineract-cn-api-docs/'>Info how to generate updated documentation yourself</a>" >> "$indexFile"

./gradlew asciidoctor

echo "Completed generating files"


