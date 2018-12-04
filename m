Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from www.llwyncelyn.cymru ([82.70.14.225]:38422 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbeLDUpq (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Tue, 4 Dec 2018 15:45:46 -0500
Date: Tue, 4 Dec 2018 20:45:08 +0000
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH V4 5/6] net: maclorawan: Implement maclorawan class
 module
Message-ID: <20181204204508.3ebead06@alans-desktop>
In-Reply-To: <20181204141341.4353-6-starnight@g.ncu.edu.tw>
References: <CAC=mGzhs0smXzRxn1k9jDFsaLNAkpCd7rMs--E-SafQVTob7JQ@mail.gmail.com>
        <20181204141341.4353-6-starnight@g.ncu.edu.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Cc: Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>, "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>, linux-wpan@vger.kernel.org, Stefan Schmidt <stefan@datenfreihafen.org>

> +void
> +lrw_parse_frame(struct lrw_session *ss, struct sk_buff *skb)
> +{
> +	struct lrw_fhdr *fhdr = &ss->rx_fhdr;
> +	__le16 *p_fcnt;
> +
> +	pr_debug("%s: %s\n", LORAWAN_MODULE_NAME, __func__);
> +
> +	/* Get message type */
> +	fhdr->mtype = skb->data[0];
> +	skb_pull(skb, LRW_MHDR_LEN);

This does not seem robust. There is no point at which you actually check
the message size is valid etc

> +	fhdr->fopts_len = fhdr->fctrl & 0xF;
> +	if (fhdr->fopts_len > 0) {
> +		memcpy(fhdr->fopts, skb->data, fhdr->fopts_len);
> +		skb_pull(skb, fhdr->fopts_len);
> +	}

In fact you appear to copy random kernel memory into a buffer
> +
> +	/* TODO: Parse frame options */
> +
> +	/* Remove message integrity code */
> +	skb_trim(skb, skb->len - LRW_MIC_LEN);

and then try and trim the buffer to a negative size ?

Alan
