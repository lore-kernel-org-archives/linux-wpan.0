Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36466 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750850AbdHBWQn (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 2 Aug 2017 18:16:43 -0400
Received: by mail-wm0-f47.google.com with SMTP id t201so845775wmt.1
        for <linux-wpan@vger.kernel.org>; Wed, 02 Aug 2017 15:16:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAB_54W5+pnKoL2LzfwfqsOOXVj0BG6dNRstJMFkrX1fG9mm=kA@mail.gmail.com>
References: <20170707110011.pwz272ppmwwu2wzh@omega> <da32b41b-ff84-9054-13d9-c03584cc5091@hm.edu>
 <20170708180631.l7lddi475pmua33o@omega> <20170708181113.htxnpxrzxgsrqyva@omega>
 <20170708181410.64zhqqyfvgp22b6c@omega> <583268dc-46a4-c78d-dfcf-d0083caa0888@hm.edu>
 <20170709182728.kam75j2kpt36ulju@omega> <3cf26613-fe30-c9a4-01f8-5a9219bf6da1@hm.edu>
 <20170710094026.4urdv5bovwiztku7@omega> <6deda57a-4a26-ecae-0846-f34174acef09@hm.edu>
 <20170710120303.5v3wikb3lkpvoao2@omega> <1a7c2fd3-fda8-765a-f055-c32302a23879@freenet.de>
 <CAOHTApjAMYz+=ngH15M3wyNKE+noSvhN0iBWarYDYv_QN-k48g@mail.gmail.com>
 <5146468f-566c-40e4-e428-9cac2b90d470@hm.edu> <CAOHTApi5ZPNRMc0Sy0BBacXWbPnaG-NMedwdb8D9DqzPYM5u4g@mail.gmail.com>
 <CAB_54W5+pnKoL2LzfwfqsOOXVj0BG6dNRstJMFkrX1fG9mm=kA@mail.gmail.com>
From: Alexander Aring <aring@mojatatu.com>
Date: Wed, 2 Aug 2017 18:16:40 -0400
Message-ID: <CAOHTApjS9h+RXtdJzCbhA+8ixYL9LvRAKa=3uLa+qHJrf277MA@mail.gmail.com>
Subject: Re: Resend : Reading corrupt IEEE 802.15.4 packages with the
 AT-REB233 and the BeagleBone Black with IWPAN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Balz <s.balz@hm.edu>
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>

Hi,

switched back to my new mail addres... sorry.

On Wed, Aug 2, 2017 at 5:55 PM, Alexander Aring <alex.aring@gmail.com> wrot=
e:
> Hi,
>
> 2017-08-02 14:59 GMT-04:00 Alexander Aring <aring@mojatatu.com>:
>> Hi,
>>
>> On Wed, Aug 2, 2017 at 1:03 PM, Balz <s.balz@hm.edu> wrote:
>>> Hi Alex,
>>>
>>> I've changed the Kernel module so that i read the Framebuffer as SRAM a=
nd
>>> not as FrameBuffer.
>>> I've write a 0x00n followed by 0x00 to determine a SRAM read from the a=
ddr
>>> 0.
>>>
>>> But the Kernel Module can not identity the frame length any more.
>>>
>>> The Sniffed packages (all Packages have 143 byte length) do not show th=
e
>>> behaviour any more.
>>>
>>> Maybe the SRAM read access is protected and the Frame-buffer Read not..=
.?
>>>
>>
>> I think frame buffer read access only.
>>
>> "Dynamic Frame Buffer Protection is released on the rising edge of pin 2=
3 (/SEL)
>>  during a Frame Buffer read access, or on the radio transceiver=E2=80=99=
s
>> state change from
>>  RX_ON or RX_AACK_ON to another state.", see [0].
>
> Please try this patch:
>
> diff --git a/drivers/net/ieee802154/at86rf230.c
> b/drivers/net/ieee802154/at86rf230.c
> index 548d9d026a85..a54f0a0d3fef 100644
> --- a/drivers/net/ieee802154/at86rf230.c
> +++ b/drivers/net/ieee802154/at86rf230.c
> @@ -709,6 +709,8 @@ at86rf230_rx_read_frame_complete(void *context)
>         struct sk_buff *skb;
>         u8 len, lqi;
>
> +       ieee802154_start_queue(lp->hw);
> +
>         len =3D buf[1];
>         if (!ieee802154_is_valid_psdu_len(len)) {
>                 dev_vdbg(&lp->spi->dev, "corrupted frame received\n");
> @@ -824,6 +826,9 @@ static irqreturn_t at86rf230_isr(int irq, void *data)
>
>         disable_irq_nosync(irq);
>
> +       if (!lp->is_tx)
> +               ieee802154_stop_queue(lp->hw);
> +
>         ctx =3D kzalloc(sizeof(*ctx), GFP_ATOMIC);
>         if (!ctx) {
>                 enable_irq(irq);
>
> I think I know what could be going on...
>
> It's "... to another state."... Maybe when a RX irq occurs during the
> spi async handling there could be some "xmit" callbacks... This will
> change the transceiver into another state... (not directly, but so far
> I know it queues for state change). So when it will automatically go
> into RX_AACK_ON then it will change the state to something else and
> allows framebuffer overwrite.

it could be that there exists a race when stop queue is running and
currently a xmit is going on...
I currently have no idea how to solve it and need to have more details
what happens when the transceiver is in BUSY_RX and we do another
state change? Will it be queued or not (so after BUSY_RX it will
change to RX_ON and then another state)?

- Alex
