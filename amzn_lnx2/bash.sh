terraform init
terraform plan
terraform apply -auto-approve


shopt -s extglob

function remove_files {
  echo "Removing files..."
  rm -rf !('main.tf'|'output.tf'|'provider.tf'|'bash.sh')
  echo "Files removed successfully."
}

# Prompt the user to confirm deletion until they enter 'yes'
while true; do
  # List the files to be removed
  echo "The following files will be removed:"
  ls -ltrah -I 'main.tf' -I 'output.tf' -I 'provider.tf' -I 'bash.sh'

  # Prompt the user to confirm deletion
  read -p "Are you sure you want to delete these files? Enter 'yes' to confirm: " answer

  # Check if the user entered 'yes'
  if [ "$answer" == "yes" ]; then
    terraform destroy -auto-approve
    remove_files
    break
  else
    echo "Deletion cancelled. Please enter 'yes' to confirm deletion."
  fi
done