Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:50768
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751987AbdHIKxC (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 9 Aug 2017 06:53:02 -0400
Subject: Re: [PATCH v0 1/2] mac802154: fix header and payload encrypted
References: <1502126560-24462-1-git-send-email-dvnp@cesar.org.br>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <7ca3098f-a309-ca09-9e3d-f9c948f1fd67@osg.samsung.com>
Date: Wed, 9 Aug 2017 12:52:58 +0200
MIME-Version: 1.0
In-Reply-To: <1502126560-24462-1-git-send-email-dvnp@cesar.org.br>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Diogenes Pereira <dvnp@cesar.org.br>, linux-wpan@vger.kernel.org
Cc: aar@pengutronix.de

Hello.

On 08/07/2017 07:22 PM, Diogenes Pereira wrote:
> According to 802.15.4-2015 specification (section 9.2.1 Outgoing frame
> security procedure) just the outgoing payload is encrypted. The header
> carries security parameters to destination address, so is not encrypted.

Did you check by any chance if that was different in the 2006 or 2003 
versions of the spec? A lot of our code is based on them and we are only 
very slowly catching up on -2015 :)

> Signed-off-by: Diogenes Pereira <dvnp@cesar.org.br>
> ---
>   net/mac802154/llsec.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mac802154/llsec.c b/net/mac802154/llsec.c
> index 1e1c9b2..3c8ae3f 100644
> --- a/net/mac802154/llsec.c
> +++ b/net/mac802154/llsec.c
> @@ -623,13 +623,18 @@ llsec_do_encrypt_unauth(struct sk_buff *skb, const struct mac802154_llsec *sec,
>   	u8 iv[16];
>   	struct scatterlist src;
>   	SKCIPHER_REQUEST_ON_STACK(req, key->tfm0);
> -	int err;
> +	int err, datalen;
> +	unsigned char *data;
>   
>   	llsec_geniv(iv, sec->params.hwaddr, &hdr->sec);
> -	sg_init_one(&src, skb->data, skb->len);
> +
> +	data = skb_mac_header(skb) + skb->mac_len;
> +	datalen = skb_tail_pointer(skb) - data;
> +
> +	sg_init_one(&src, data, datalen);
>   	skcipher_request_set_tfm(req, key->tfm0);
>   	skcipher_request_set_callback(req, 0, NULL, NULL);
> -	skcipher_request_set_crypt(req, &src, &src, skb->len, iv);
> +	skcipher_request_set_crypt(req, &src, &src, datalen, iv);
>   	err = crypto_skcipher_encrypt(req);
>   	skcipher_request_zero(req);
>   	return err;

What systems did you test this against? Do you have a specific error 
scenario which this patch fixes?

What I try to understand here is if we are going to break llsec 
communication with other systems already out there.

regards
Stefan Schmidt
