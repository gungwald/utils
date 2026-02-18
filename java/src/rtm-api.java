Unirest.setTimeouts(0, 0);
HttpResponse<String> response = Unirest.get("https://api.rememberthemilk.com/services/rest?api_key=2ced8adb82d476bf6c53780a09b99c6b&method=rtm.auth.getFrob")
  .asString();

// Generate the signature for the request
const CryptoJS = require("crypto-js"); // Import CryptoJS library for MD5 hashing

// Generate the signature using MD5 hashing
function generateSignature(api_sig) {
    console.log(pm.request.url.getQueryString());
}
generateSignature("");

const url = pm.request.url.toString(); // Get the current request URL
const method = pm.request.method.toString(); // Get the current request method
const frob = pm.response.json().frob; // Assuming the response contains a frob value

const api_key = pm.collectionVariables.get("api_key").toString();
const shared_secret = pm.collectionVariables.get("shared_secret").toString();
const perms = pm.collectionVariables.get("perms");
var api_sig = shared_secret + "api_key" + api_key + "perms" + perms;
api_sig = CryptoJS.MD5(api_sig).toString();
pm.request.addQueryParams(
    [
        { key : "api_sig", value : api_sig }
    ]
);
