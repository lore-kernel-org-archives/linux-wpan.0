Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailgw1.uni-kl.de ([131.246.120.220]:36066 "EHLO
	mailgw1.uni-kl.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289AbbFRWgq (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Jun 2015 18:36:46 -0400
Received: from itwm2.itwm.fhg.de (itwm2.itwm.fhg.de [131.246.191.3])
	by mailgw1.uni-kl.de (8.14.4/8.14.4/Debian-7) with ESMTP id t5IMagek003801
	for <linux-wpan@vger.kernel.org>; Fri, 19 Jun 2015 00:36:43 +0200
Message-ID: <e34b827ea629ea14ef7fb9f1627394a3.squirrel@webmail.itwm.fhg.de>
In-Reply-To: <1434642901-11646-1-git-send-email-simon.vincent@xsilon.com>
References: <1434642901-11646-1-git-send-email-simon.vincent@xsilon.com>
Date: Fri, 19 Jun 2015 00:36:41 +0200
Subject: Re: [PATCH bluetooth-next] mac802154: fix llsec authentication
 without encryption BUG
From: "Phoebe Buckheister" <phoebe.buckheister@itwm.fraunhofer.de>
Reply-To: phoebe.buckheister@itwm.fraunhofer.de
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: alex.aring@gmail.com, linux-wpan@vger.kernel.org, phoebe.buckheister@itwm.fraunhofer.de

Reviewed-By: Phoebe Buckheister <phoebe.buckheister@itwm.fraunhofer.de>

On Thu, June 18, 2015 5:55 pm, Simon Vincent wrote:
>  802.15.4 security levels 1,2,3 provide data authenticity but
>  no encryption. Currently the llsec implementation hits a BUG() if these
> modes
>  are used. This is due to the scatterlist length being set to 0 when
>  encryption is not used. This patch fixes this issue.
>
> Signed-off-by: Simon Vincent <simon.vincent@xsilon.com>
> ---
>  net/mac802154/llsec.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/net/mac802154/llsec.c b/net/mac802154/llsec.c
> index 5b2be12..f8081f0 100644
> --- a/net/mac802154/llsec.c
> +++ b/net/mac802154/llsec.c
> @@ -648,7 +648,8 @@ llsec_do_encrypt_auth(struct sk_buff *skb, const
> struct mac802154_llsec *sec,
>  {
>  	u8 iv[16];
>  	unsigned char *data;
> -	int authlen, assoclen, datalen, rc;
> +	int authlen, datalen, rc;
> +	int assoclen = 0;
>  	struct scatterlist src, assoc[2], dst[2];
>  	struct aead_request *req;
>
> @@ -659,26 +660,25 @@ llsec_do_encrypt_auth(struct sk_buff *skb, const
> struct mac802154_llsec *sec,
>  	if (!req)
>  		return -ENOMEM;
>
> -	sg_init_table(assoc, 2);
> -	sg_set_buf(&assoc[0], skb_mac_header(skb), skb->mac_len);
> -	assoclen = skb->mac_len;
> -
>  	data = skb_mac_header(skb) + skb->mac_len;
>  	datalen = skb_tail_pointer(skb) - data;
>
>  	if (hdr->sec.level & IEEE802154_SCF_SECLEVEL_ENC) {
> -		sg_set_buf(&assoc[1], data, 0);
> +		sg_init_table(assoc, 1);
> +		sg_init_table(dst, 2);
> +		sg_set_buf(&dst[0], data, datalen);
> +		sg_set_buf(&dst[1], skb_put(skb, authlen), authlen);
> +		sg_init_one(&src, data, datalen);
>  	} else {
> +		sg_init_table(assoc, 2);
>  		sg_set_buf(&assoc[1], data, datalen);
>  		assoclen += datalen;
>  		datalen = 0;
> +		sg_init_one(dst, skb_put(skb, authlen), authlen);
>  	}
>
> -	sg_init_one(&src, data, datalen);
> -
> -	sg_init_table(dst, 2);
> -	sg_set_buf(&dst[0], data, datalen);
> -	sg_set_buf(&dst[1], skb_put(skb, authlen), authlen);
> +	sg_set_buf(&assoc[0], skb_mac_header(skb), skb->mac_len);
> +	assoclen += skb->mac_len;
>
>  	aead_request_set_callback(req, 0, NULL, NULL);
>  	aead_request_set_assoc(req, assoc, assoclen);
> --
> 1.9.1
>
>


