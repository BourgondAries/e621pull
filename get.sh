tags=$(echo "$1" | sed 's/ /%20/g')
while [ true ]; do
	wget "https://e621.net/post/index/1/$tags?searchDefault=Search" -O temporary
	lastpage=$(cat temporary | grep 'searchDefault=Search' | sed "s/<\/a>/\n/g" | tail -n 3 | head -n 1 | cut -d '>' -f 2)

	randompage=$(shuf -i 1-$lastpage -n 1)
	wget "https://e621.net/post/index/$randompage/mlp%20rating:e?searchDefault=Search" -O temporary
	posts=$(cat temporary | grep 'class="thumb"' | sed 's/<span.*href=//g' | cut -d '"' -f 2)

	postcount=$(echo "$posts" | wc -l)
	randompost=$(shuf -i 1-$postcount -n 1)

	link=$(echo "$posts" | head -n $randompost | tail -n 1)
	link="https://e621.net$link"

	echo "$link" | xsel --clipboard
	xdotool mousemove 600 950
	sleep 1s
	xdotool click 1
	sleep 1s
	xdotool keydown ctrl
	xdotool key v
	xdotool keyup ctrl
	sleep 1s
	xdotool key KP_Enter
done
