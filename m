Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:42711
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756602AbcLPNEi (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 16 Dec 2016 08:04:38 -0500
Subject: Re: [PATCH wpan-tools] wpan-ping: Add the filtering function for
 frame receiving
References: <1481873430-4965-1-git-send-email-wsn.iot.xwq@cn.fujitsu.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <5c134ecc-9b51-7a1f-aade-8de517428b8b@osg.samsung.com>
Date: Fri, 16 Dec 2016 14:04:34 +0100
MIME-Version: 1.0
In-Reply-To: <1481873430-4965-1-git-send-email-wsn.iot.xwq@cn.fujitsu.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: wsn.iot.xwq@cn.fujitsu.com, linux-wpan@vger.kernel.org
Cc: aar@pengutronix.de

Hello.

On 16/12/16 08:30, wsn.iot.xwq@cn.fujitsu.com wrote:
> From: Xue Wenqian <wsn.iot.xwq@cn.fujitsu.com>
>
> Hi,
>
> Let me make some explanations for the patch:

No need to start the commit message like a mail. Just the description is 
fine. :)

> 1. The filtering for client is made by checking frame header and sequence number

Sequence we did before as well so the additional check is for the header 
here.

> 2. Also, when client receives the incorrect frame, it will update new timeout value and receive again until correct frame is received or timeout

What happens when a frame is really lost?

> 3. The filtering for server is made by just checking frame header

Guess that should help a bit to protect against 6LoWPAN traffic, but for 
every other protocol setting the not a 6LoWPAN header this will not 
work. Nothing we can do against though.

> 4. For code reuse, I replace sleeping() with get_interval() function
>
> Signed-off-by: Xue Wenqian <wsn.iot.xwq@cn.fujitsu.com>
> ---
>  wpan-ping/wpan-ping.c |   86 ++++++++++++++++++++++++++++++-------------------
>  1 file changed, 53 insertions(+), 33 deletions(-)
>
> diff --git a/wpan-ping/wpan-ping.c b/wpan-ping/wpan-ping.c
> index e6df2b4..15a2a4b 100644
> --- a/wpan-ping/wpan-ping.c
> +++ b/wpan-ping/wpan-ping.c
> @@ -235,28 +235,30 @@ static int print_address(char *addr, uint8_t dst_extended[IEEE802154_ADDR_LEN])
>  	return 0;
>  }
>
> -static void sleeping(struct timeval ping_start_time, struct timeval timeout) {
> -	struct timeval curr_time;
> -	long sec, usec, interval_usec, timeout_usec;
> -	long sleep_usec = 0;
> -	gettimeofday(&curr_time, NULL);
> -	sec = curr_time.tv_sec - ping_start_time.tv_sec;
> -	usec = curr_time.tv_usec - ping_start_time.tv_usec;
> -	if (usec < 0) {
> -		usec += 1000000;
> -		sec--;
> +/* time interval computation */
> +static long get_interval(struct timeval start_time, struct timeval end_time, long timeout_usec) {
> +	long sec, usec, usecs, interval_usec = 0;
> +	sec = end_time.tv_sec - start_time.tv_sec;
> +	usec = end_time.tv_usec - start_time.tv_usec;
> +	usecs = sec * 1000000 + usec;
> +	if (usecs < timeout_usec) {
> +		interval_usec = timeout_usec - usecs;
>  	}
> -	interval_usec = sec * 1000000 + usec;
> -	timeout_usec = timeout.tv_sec * 1000000 + timeout.tv_usec;
> -	if (interval_usec < timeout_usec) {
> -		sleep_usec = timeout_usec - interval_usec;
> -		usleep(sleep_usec);
> +	return interval_usec;
> +}
> +
> +/* recv timeout setting */
> +static void set_so_rcvtimeo(int sd, struct timeval timeout) {
> +	int ret;
> +	ret = setsockopt(sd, SOL_SOCKET, SO_RCVTIMEO, (struct timeval *)&timeout, sizeof(struct timeval));
> +	if (ret < 0) {
> +		perror("setsockopt receive timeout");
>  	}
>  }
>
>  static int measure_roundtrip(struct config *conf, int sd) {
>  	unsigned char *buf;
> -	struct timeval ping_start_time, start_time, end_time, timeout;
> +	struct timeval ping_start_time, start_time, end_time, ping_end_time, timeout, new_timeout;
>  	long sec = 0, usec = 0;
>  	long sec_max = 0, usec_max = 0;
>  	long sec_min = 2147483647, usec_min = 2147483647;
> @@ -266,6 +268,8 @@ static int measure_roundtrip(struct config *conf, int sd) {
>  	float rtt_min = 0.0, rtt_avg = 0.0, rtt_max = 0.0;
>  	float packet_loss = 100.0;
>  	char addr[24];
> +	long timeout_usec, interval_usec, sleep_usec;
> +	int set_so_rcvtimeo_flag;
>
>  	if (conf->extended)
>  		print_address(addr, conf->dst.addr.hwaddr);
> @@ -287,10 +291,9 @@ static int measure_roundtrip(struct config *conf, int sd) {
>  		timeout.tv_sec = 0;
>  		timeout.tv_usec = conf->interval * 1000;
>  	}
> -	ret = setsockopt(sd, SOL_SOCKET, SO_RCVTIMEO, (struct timeval *)&timeout,sizeof(struct timeval));
> -	if (ret < 0) {
> -		perror("setsockopt receive timeout");
> -	}
> +	timeout_usec = conf->interval * 1000;
> +	set_so_rcvtimeo(sd, timeout);
> +	set_so_rcvtimeo_flag = 1;
>
>  	count = 0;
>  	for (i = 0; i < conf->packets; i++) {
> @@ -302,13 +305,24 @@ static int measure_roundtrip(struct config *conf, int sd) {
>  			perror("sendto");
>  		}
>  		gettimeofday(&start_time, NULL);
> -		ret = recv(sd, buf, conf->packet_len, 0);
> -		if (seq_num != ((buf[2] << 8)| buf[3])) {
> -			printf("Sequenze number did not match\n");
> -			continue;
> +		while(1) {
> +			ret = recv(sd, buf, conf->packet_len, 0);
> +			gettimeofday(&end_time, NULL);
> +			interval_usec = get_interval(ping_start_time, end_time, timeout_usec);
> +			if (interval_usec > 0 && (buf[0] != '\000' || seq_num != ((buf[2] << 8)| buf[3]))) {

The header check could be buf[0] !=  NOT_A_6LOWPAN_FRAME
That way it is clearer what we are checking on.

> +				fprintf(stderr, "Packet %i: Sequence number did not match, receive again!\n", i);
> +				new_timeout.tv_sec = (int)(interval_usec * 1.0 / 1000000);
> +				new_timeout.tv_usec = interval_usec - (new_timeout.tv_sec * 1000000);
> +				set_so_rcvtimeo(sd, new_timeout);
> +				set_so_rcvtimeo_flag = 0;
> +			} else {
> +				if (set_so_rcvtimeo_flag == 0) {
> +					set_so_rcvtimeo(sd, timeout);
> +				}
> +				break;
> +			}
>  		}
>  		if (ret > 0) {
> -			gettimeofday(&end_time, NULL);
>  			count++;
>  			sec = end_time.tv_sec - start_time.tv_sec;
>  			sum_sec += sec;
> @@ -338,9 +352,13 @@ static int measure_roundtrip(struct config *conf, int sd) {
>  				fprintf(stdout, "%i bytes from 0x%04x seq=%i time=%.1f ms\n", ret,
>  					conf->dst.addr.short_addr, (int)seq_num, (float)usec/1000);
>  		} else
> -			fprintf(stderr, "Hit %i ms packet timeout\n", conf->interval);
> +			fprintf(stderr, "Packet %i: Hit %i ms packet timeout\n", i, conf->interval);
>  		/* sleeping */
> -		sleeping(ping_start_time, timeout);
> +		gettimeofday(&ping_end_time, NULL);
> +		sleep_usec = get_interval(ping_start_time, ping_end_time, timeout_usec);
> +		if (sleep_usec > 0) {
> +			usleep(sleep_usec);
> +		}
>  	}
>
>  	if (count)
> @@ -386,11 +404,13 @@ static void init_server(int sd) {
>  #if DEBUG
>  		dump_packet(buf, len);
>  #endif
> -		/* Send same packet back */
> -		len = sendto(sd, buf, len, 0, (struct sockaddr *)&src, addrlen);
> -		if (len < 0) {
> -			perror("sendto");
> -			continue;
> +		if (buf[0] == '\000') {

Something like if(buf[0] == NOT_A_6LOWPAN_FRAME) would be clearer.

> +			/* Send same packet back */
> +			len = sendto(sd, buf, len, 0, (struct sockaddr *)&src, addrlen);
> +			if (len < 0) {
> +				perror("sendto");
> +				continue;
> +			}
>  		}
>  	}
>  	free(buf);
> @@ -559,4 +579,4 @@ int main(int argc, char *argv[]) {
>  	init_network(conf);
>  	free(conf);
>  	return 0;
> -}
> +}

What is this change? Some extra whitespace?

regards
Stefan Schmidt
