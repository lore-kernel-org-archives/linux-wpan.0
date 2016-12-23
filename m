Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:39006
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S966463AbcLWKqj (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 23 Dec 2016 05:46:39 -0500
Subject: Re: [PATCH wpan-tools v2] wpan-ping: Add the filtering function for
 frame receiving
References: <1482299344-4128-1-git-send-email-wsn.iot.xwq@cn.fujitsu.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <a44d82e0-9309-7939-9538-6eb7f291681c@osg.samsung.com>
Date: Fri, 23 Dec 2016 11:46:34 +0100
MIME-Version: 1.0
In-Reply-To: <1482299344-4128-1-git-send-email-wsn.iot.xwq@cn.fujitsu.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: wsn.iot.xwq@cn.fujitsu.com, linux-wpan@vger.kernel.org
Cc: aar@pengutronix.de

Hello.

On 21/12/16 06:49, wsn.iot.xwq@cn.fujitsu.com wrote:
> From: Xue Wenqian <wsn.iot.xwq@cn.fujitsu.com>
>
> The filtering for wpan-ping client and server is made by checking frame header.
>
> Signed-off-by: Xue Wenqian <wsn.iot.xwq@cn.fujitsu.com>
> ---
>  wpan-ping/wpan-ping.c |   16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/wpan-ping/wpan-ping.c b/wpan-ping/wpan-ping.c
> index e6df2b4..f825b22 100644
> --- a/wpan-ping/wpan-ping.c
> +++ b/wpan-ping/wpan-ping.c
> @@ -303,6 +303,10 @@ static int measure_roundtrip(struct config *conf, int sd) {
>  		}
>  		gettimeofday(&start_time, NULL);
>  		ret = recv(sd, buf, conf->packet_len, 0);
> +		if (buf[0] != NOT_A_6LOWPAN_FRAME) {
> +			printf("Non-wpanping packet was received\n");
> +			continue;
> +		}
>  		if (seq_num != ((buf[2] << 8)| buf[3])) {
>  			printf("Sequenze number did not match\n");
>  			continue;
> @@ -386,11 +390,13 @@ static void init_server(int sd) {
>  #if DEBUG
>  		dump_packet(buf, len);
>  #endif
> -		/* Send same packet back */
> -		len = sendto(sd, buf, len, 0, (struct sockaddr *)&src, addrlen);
> -		if (len < 0) {
> -			perror("sendto");
> -			continue;
> +		if (buf[0] == NOT_A_6LOWPAN_FRAME) {
> +			/* Send same packet back */
> +			len = sendto(sd, buf, len, 0, (struct sockaddr *)&src, addrlen);
> +			if (len < 0) {
> +				perror("sendto");
> +				continue;
> +			}
>  		}
>  	}
>  	free(buf);
>

Applied and pushed. Thanks!

regards
Stefan Schmidt
