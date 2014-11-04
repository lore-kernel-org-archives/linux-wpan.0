Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:64763 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753793AbaKDOmm (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 4 Nov 2014 09:42:42 -0500
Date: Tue, 4 Nov 2014 15:42:34 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCHv2 bluetooth-next] 6lowpan: fix udp header compression
 when using raw sockets
Message-ID: <20141104144232.GA30647@omega>
References: <1415111693-1711-1-git-send-email-simon.vincent@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1415111693-1711-1-git-send-email-simon.vincent@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org

On Tue, Nov 04, 2014 at 02:34:53PM +0000, Simon Vincent wrote:
> If you use RAW sockets the transport header offset is not set by the
> ipv6 stack so when we get to the udp header compression it does not
> compress the right part of the packet.
> 
> This patch adds a check for this scenario and sets the transport
> header offset.
> 
> Signed-off-by: Simon Vincent <simon.vincent@xsilon.com>
> ---
>  net/6lowpan/iphc.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
> index 73a7065..305bf2b 100644
> --- a/net/6lowpan/iphc.c
> +++ b/net/6lowpan/iphc.c
> @@ -512,9 +512,17 @@ static u8 lowpan_compress_addr_64(u8 **hc_ptr, u8 shift,
>  
>  static void compress_udp_header(u8 **hc_ptr, struct sk_buff *skb)
>  {
> -	struct udphdr *uh = udp_hdr(skb);
> +	struct udphdr *uh;
>  	u8 tmp;
>  
> +	/* In the case of RAW sockets the transport header is not set by
> +	* the ip6 stack so we must set it ourselves
> +	*/

Should be:

	/* In the case of RAW sockets the transport header is not set by
	 * the ip6 stack so we must set it ourselves
	 */

Otherwise looking good! ;-)

- Alex

