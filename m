Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:44794
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751133AbdINNj5 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 14 Sep 2017 09:39:57 -0400
Subject: Re: [PATCH v1 1/2] mac802154: Fix MAC header and payload encrypted
References: <CAC9NHkkHZJLk7_shZ37jFqp06Gu9Qg1Eu=sGi_259GjhkpSftg@mail.gmail.com>
 <1504613884-20870-1-git-send-email-dvnp@cesar.org.br>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <c72cbf52-39fb-0898-0829-e14727e87724@osg.samsung.com>
Date: Thu, 14 Sep 2017 15:39:53 +0200
MIME-Version: 1.0
In-Reply-To: <1504613884-20870-1-git-send-email-dvnp@cesar.org.br>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Diogenes Pereira <dvnp@cesar.org.br>, linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com, ckt@cesar.org.br

Hello.

On 09/05/2017 02:18 PM, Diogenes Pereira wrote:
> According to  802.15.4-2003/2006/2015 specifications the MAC frame is
> composed of MHR, MAC payload and MFR and just the outgoing MAC payload
> must be encrypted.
> 
> If communication is secure,sender build Auxiliary Security Header(ASH),
> insert it next to the standard MHR header with security enabled bit ON,
> and secure frames before transmitting them. According to the information
> carried within the ASH, recipient retrieves the right cryptographic key
> and correctly un-secure MAC frames.
> 
> The error scenario occurs on Linux using IEEE802154_SCF_SECLEVEL_ENC(4)
> security level when llsec_do_encrypt_unauth() function builds theses MAC
> frames incorrectly. On recipients these MAC frames are discarded,logging
> "got invalid frame" messages.
> 
> Acked-by: Stefan Schmidt <stefan@osg.samsung.com>
> Signed-off-by: Diogenes Pereira <dvnp@cesar.org.br>

While it shows me Acked-By it was missing so far.

To make it clear I am ok with this patch now.

Acked-by: Stefan Schmidt <stefan@osg.samsung.com>

regards
Stefan Schmidt

> ---
>   net/mac802154/llsec.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mac802154/llsec.c b/net/mac802154/llsec.c
> index 1e1c9b2..d9e7105 100644
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
> +	/* Compute data payload offset and data length */
> +	data = skb_mac_header(skb) + skb->mac_len;
> +	datalen = skb_tail_pointer(skb) - data;
> +	sg_init_one(&src, data, datalen);
> +
>   	skcipher_request_set_tfm(req, key->tfm0);
>   	skcipher_request_set_callback(req, 0, NULL, NULL);
> -	skcipher_request_set_crypt(req, &src, &src, skb->len, iv);
> +	skcipher_request_set_crypt(req, &src, &src, datalen, iv);
>   	err = crypto_skcipher_encrypt(req);
>   	skcipher_request_zero(req);
>   	return err;
> 
