for var in "$@"
do
    case "$var" in

host|all)               	echo "1" #cd build/host
                      		#ninja
                      		#cd ../..
                      		;;
arm-linux-gnueabi|all)  	echo "2" #cd build/arm-linux-gnueabi
                      		#ninja lldb-server
                      		#cd ../..
                      		;;
arm-linux-gnueabihf|all)  	echo "3" #cd build/arm-linux-gnueabihf
				#ninja lldb-server
				#cd ../..
    				;;
aarch64-linux-gnu|all) 		echo "4" #cd build/aarch64-linux-gnu
				#ninja lldb-server
				#cd ../..
   				;;
android-arm32|all)   	echo "5" #cd build/android-arm32
			#ninja lldb-server
			#cd ../..
   			;;
android-arm64|all) 		echo "6" #cd build/android-arm64
			#ninja lldb-server
			#cd ../..
   ;;

*) echo "$var"
   ;;
esac
done


function host {
               cd build/host
               ninja
               cd ../..
           }

function arm-linux-gnueabi {
               cd build/host
               ninja
               cd ../..
           }

function arm-linux-gnueabihf {
               cd build/host
               ninja
               cd ../..
           }

function aarch64-linux-gnu {
               cd build/host
               ninja
               cd ../..
           }

function android-arm32 {
               cd build/host
               ninja
               cd ../..
           }

function android-arm64 {
               	cd build/android-arm64
		ninja lldb-server
		cd ../..
           }

