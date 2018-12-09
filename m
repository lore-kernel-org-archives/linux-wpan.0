Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44529 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbeLII1O (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 9 Dec 2018 03:27:14 -0500
Received: by mail-oi1-f194.google.com with SMTP id m6so6658032oig.11
        for <linux-wpan@vger.kernel.org>; Sun, 09 Dec 2018 00:27:13 -0800 (PST)
MIME-Version: 1.0
References: <CAC=mGzhs0smXzRxn1k9jDFsaLNAkpCd7rMs--E-SafQVTob7JQ@mail.gmail.com>
 <20181204141341.4353-6-starnight@g.ncu.edu.tw> <20181204204508.3ebead06@alans-desktop>
In-Reply-To: <20181204204508.3ebead06@alans-desktop>
From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Date: Sun, 9 Dec 2018 16:27:15 +0800
Message-ID: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
Subject: Re: [PATCH V4 5/6] net: maclorawan: Implement maclorawan class module
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, "<linux-arm-kernel@lists.infradead.org\\" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org>," <linux-kernel@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>, Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>, Stefan Schmidt <stefan@datenfreihafen.org>

I made a fake skb and passed it to lrw_parse_frame() function for
testing.  I use print_hex_dump() function to show the skb's content.
Here is the original content in the skb->data and the length is 20 bytes.

[   33.732033] 00000000: 40 04 03 02 01 00 00 00 00 27 76 d3 2d 1b 79
a0  @........'v.-.y.
[   33.732065] 00000010: 18 38 fb a6                                      .8..

Byte 0: MHDR field, value is 0x40.
Byte 1 ~ 4: DevAddr field, value is 0x04 0x03 0x02 0x01.
Byte 5: FCtrl field, value is 0x00.
Byte 6 ~ 7: FCnt field, value is 0x00 0x00.
Byte 8: FPort field, value is 0x00.
Byte 9 ~ 15: Encrypted payload
Byte 16 ~ 19: MIC field value is 0x18 0x38 0xfb 0xa6.

> > +void
> > +lrw_parse_frame(struct lrw_session *ss, struct sk_buff *skb)
> > +{
> > +     struct lrw_fhdr *fhdr = &ss->rx_fhdr;
> > +     __le16 *p_fcnt;
> > +
> > +     pr_debug("%s: %s\n", LORAWAN_MODULE_NAME, __func__);
> > +
> > +     /* Get message type */
> > +     fhdr->mtype = skb->data[0];
> > +     skb_pull(skb, LRW_MHDR_LEN);

print_hex_dump skb here:
[   33.732202] 00000000: 04 03 02 01 00 00 00 00 27 76 d3 2d 1b 79 a0
18  ........'v.-.y..
[   33.732204] 00000010: 38 fb a6

> This does not seem robust. There is no point at which you actually check
> the message size is valid etc

Thanks!  It is a potential bug.
It should check skb->len >= length of MHDR + DevAddr + FCtrl + FCnt + MIC.
These are required fields for (Un)confirmed Data Up/Down messages.


print_hex_dump skb here:
[   33.732211] 00000000: 00 27 76 d3 2d 1b 79 a0 18 38 fb a6
   .'v.-.y..8..

> > +     fhdr->fopts_len = fhdr->fctrl & 0xF;
> > +     if (fhdr->fopts_len > 0) {
> > +             memcpy(fhdr->fopts, skb->data, fhdr->fopts_len);
> > +             skb_pull(skb, fhdr->fopts_len);
> > +     }

print_hex_dump skb here:
[   33.732213] 00000000: 00 27 76 d3 2d 1b 79 a0 18 38 fb a6
   .'v.-.y..8..

> In fact you appear to copy random kernel memory into a buffer

It copied fhdr->fopts_len bytes from skb->data to fhdr->fopts if
fhdr->fopts_len > 0.
https://www.kernel.org/doc/html/latest/core-api/kernel-api.html?highlight=memcpy#c.memcpy

> > +
> > +     /* TODO: Parse frame options */
> > +
> > +     /* Remove message integrity code */
> > +     skb_trim(skb, skb->len - LRW_MIC_LEN);

print_hex_dump skb here:
[   33.732216] 00000000: 00 27 76 d3 2d 1b 79 a0
   .'v.-.y.

> and then try and trim the buffer to a negative size ?

It removed 4 tail bytes (MIC).  (skb->len - LRW_MIC_LEN) is the final
new length as skb_trim()'s 2nd argument len.
https://www.kernel.org/doc/html/latest/networking/kapi.html?highlight=skb_trim#c.skb_trim

I found another bug which did not initialize rx_skb_list.  So,
lrw_parse_frame() may be passed a mystery skb.

Please keep reviewing.  That is appreciated.

Thank you,
Jian-Hong Pan
