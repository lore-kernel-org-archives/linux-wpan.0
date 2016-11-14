Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:32805
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751522AbcKNNlc (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 14 Nov 2016 08:41:32 -0500
Subject: Re: [PATCH] Add the support for setting wpan-ping interval
References: <576133E7D398244EA0325FF7CE2A09E5CD56E161@G08CNEXMBPEKD02.g08.fujitsu.local>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <1c247e23-fde1-5b54-4fd9-b759dc0cd901@osg.samsung.com>
Date: Mon, 14 Nov 2016 14:41:23 +0100
MIME-Version: 1.0
In-Reply-To: <576133E7D398244EA0325FF7CE2A09E5CD56E161@G08CNEXMBPEKD02.g08.fujitsu.local>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "Xue, Wenqian" <xuewenqian@cn.fujitsu.com>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

Hello.

Thanks for your patch. Find my comments below.

On 14/11/16 04:09, Xue, Wenqian wrote:
> Hi, all
>
> Below shows my patch for the support to set wpan-ping interval, you can use the command `-I $interval(ms)` to set the interval value (default is 500ms).
> If you find some errors or unexpected affects on current kernel, please feel free to point it out and give me some advice, thank you all!
>

Please use git send-email to send patches. That way I can properly  
review and more important apply and test them here.

Bonus points if you use a wpan-tools prefix in the patch like this:

git format-patch --subject-prefix="PATCH wpan-tools" ...


> diff --git a/wpan-ping.c b/wpan-ping.c
> index 2c63758..4a0f00d 100644
> --- a/wpan-ping.c
> +++ b/wpan-ping.c
> @@ -49,6 +49,7 @@
>  #define IEEE802154_ADDR_LEN 8
>  /* Set the dispatch header to not 6lowpan for compat */
>  #define NOT_A_6LOWPAN_FRAME 0x00
> +#define DEFAULT_INTERVAL 500
>
>  #define DEBUG 0
>
> @@ -96,6 +97,7 @@ struct config {
>  	int nl802154_id;
>  	struct sockaddr_ieee802154 src;
>  	struct sockaddr_ieee802154 dst;
> +	unsigned short interval;
>  };
>
>  extern char *optarg;
> @@ -109,6 +111,7 @@ static void usage(const char *name) {
>  	"--count | -c number of packets\n"
>  	"--size | -s packet length\n"
>  	"--interface | -i listen on this interface (default wpan0)\n"
> +	"--interval | -I wait interval milliseconds between sending each packet (default 500ms)\n"

Maybe write: wait interval in milliseconds between sending packets  
(default 500ms)



>  	"--version | -v print out version\n"
>  	"--help | -h this usage text\n", name);
>  }
> @@ -232,6 +235,27 @@ static int print_address(char *addr, uint8_t dst_extended[IEEE802154_ADDR_LEN])
>  	return 0;
>  }
>
> +static void sleeping(struct timeval ping_start_time, struct timeval timeout)
> +{
> +	struct timeval curr_time;
> +	long sec, usec, interval_usec, timeout_usec;
> +	long sleep_usec = 0;
> +	gettimeofday(&curr_time, NULL);
> +	sec = curr_time.tv_sec - ping_start_time.tv_sec;
> +	usec = curr_time.tv_usec - ping_start_time.tv_usec;
> +	if (usec < 0)
> +	{
> +		usec += 1000000;
> +		sec--;
> +	}
> +	interval_usec = sec * 1000000 + usec;
> +	timeout_usec = timeout.tv_sec * 1000000 + timeout.tv_usec;
> +	if (interval_usec < timeout_usec){
> +		sleep_usec = timeout_usec - interval_usec;
> +		usleep(sleep_usec);
> +	}
> +}
> +
>  static int measure_roundtrip(struct config *conf, int sd) {
>  	unsigned char *buf;
>  	struct timeval start_time, end_time, timeout;
> @@ -256,9 +280,17 @@ static int measure_roundtrip(struct config *conf, int sd) {
>  			conf->dst.addr.short_addr, conf->dst.addr.pan_id, conf->packet_len);
>  	buf = (unsigned char *)malloc(MAX_PAYLOAD_LEN);
>
> -	/* 500ms seconds packet receive timeout */
> -	timeout.tv_sec = 0;
> -	timeout.tv_usec = 500000;
> +	/* default 500ms seconds packet receive timeout */
> +	// timeout.tv_sec = 0;
> +	// timeout.tv_usec = 500000;


Please do not leave commented out code here. You moved the default value  
into a define and use it accordingly so you can safely remove this here.

> +	if (conf->interval >= 1000){ // when interval is larger than 1s

No C++ style comments please. Use /* */

> +		double intervalD = (conf->interval * 1.0) / 1000;

intervalD as variable name is not very nice. Please choose something else.

> +		timeout.tv_sec = (int)intervalD;
> +		timeout.tv_usec = (int)((intervalD - timeout.tv_sec) * 1000000);
> +	} else {
> +		timeout.tv_sec = 0;
> +		timeout.tv_usec = conf->interval * 1000;
> +	}
>  	ret = setsockopt(sd, SOL_SOCKET, SO_RCVTIMEO, (struct timeval *)&timeout,sizeof(struct timeval));
>  	if (ret < 0) {
>  		perror("setsockopt receive timeout");
> @@ -266,6 +298,7 @@ static int measure_roundtrip(struct config *conf, int sd) {
>
>  	count = 0;
>  	for (i = 0; i < conf->packets; i++) {
> +		gettimeofday(&ping_start_time, NULL);
>  		generate_packet(buf, conf, i);
>  		seq_num = (buf[2] << 8)| buf[3];
>  		ret = sendto(sd, buf, conf->packet_len, 0, (struct sockaddr *)&conf->dst, sizeof(conf->dst));
> @@ -309,7 +342,9 @@ static int measure_roundtrip(struct config *conf, int sd) {
>  				fprintf(stdout, "%i bytes from 0x%04x seq=%i time=%.1f ms\n", ret,
>  					conf->dst.addr.short_addr, (int)seq_num, (float)usec/1000);
>  		} else
> -			fprintf(stderr, "Hit 500 ms packet timeout\n");
> +			fprintf(stderr, "Hit %d ms packet timeout\n", conf->interval);
> +		// sleeping
>

C++ comment. See above.

  +		sleeping(ping_start_time, timeout);
>  	}
>
>  	if (count)
> @@ -456,6 +491,9 @@ int main(int argc, char *argv[]) {
>  	/* Default to 65535 packets being sent */
>  	conf->packets = USHRT_MAX;
>
> +	/* Default to 500ms for interval value */
> +	conf->interval = DEFAULT_INTERVAL;
> +
>  	if (argc < 2) {
>  		usage(argv[0]);
>  		exit(1);
> @@ -464,9 +502,9 @@ int main(int argc, char *argv[]) {
>  	while (1) {
>  #ifdef _GNU_SOURCE
>  		int opt_idx = -1;
> -		c = getopt_long(argc, argv, "a:ec:s:i:dvh", perf_long_opts, &opt_idx);
> +		c = getopt_long(argc, argv, "a:ec:s:i:dvhI:", perf_long_opts, &opt_idx);
>  #else
> -		c = getopt(argc, argv, "a:ec:s:i:dvh");
> +		c = getopt(argc, argv, "a:ec:s:i:dvhI:");
>  #endif
>  		if (c == -1)
>  			break;
> @@ -495,6 +533,9 @@ int main(int argc, char *argv[]) {
>  		case 'i':
>  			conf->interface = optarg;
>  			break;
> +		case 'I':
> +			conf->interval = atoi(optarg);
> +			break;
>  		case 'v':
>  			fprintf(stdout, "wpan-ping " PACKAGE_VERSION "\n");
>  			free(conf);
>

Please change what I mentioned above and resend this patch with git  
send-email. Write a good commit message and do not forgot the signed-off  
line (-s for git format-patch can also generate this for you)

The change itself looks ok on a first glance at the code but I need to  
actual compile and test it.

regards
Stefan Schmidt
