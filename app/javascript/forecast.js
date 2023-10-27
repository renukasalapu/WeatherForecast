document.getElementById("form_submit").addEventListener("click", function (event) {
  const zipCodeData = document.getElementById('zip_code');
  const zipCode = zipCodeData.value.trim();
  var error_data = document.getElementById('zip_error')
  if (!/(^\d{5}$)|(^\d{9}$)|(^\d{5}-\d{4}$)|(^\d{6}$)/.test(zipCode)) {

    error_data.style.color = 'red'
    error_data.innerHTML = 'Please enter a valid ZIP code.'
    zipCodeData.focus();
    event.preventDefault();
  }
  else{
    error_data.innerHTML = ''
  }
})