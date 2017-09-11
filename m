Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wr0-f179.google.com ([209.85.128.179]:33944 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751744AbdIKMrS (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 11 Sep 2017 08:47:18 -0400
Received: by mail-wr0-f179.google.com with SMTP id v109so14382174wrc.1
        for <linux-wpan@vger.kernel.org>; Mon, 11 Sep 2017 05:47:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJuUDwtyf_TdGR34oKmLRgRU_jy+JtUSmSt1v_j20e+BwrfA7A@mail.gmail.com>
References: <20170910093026.4386-1-starnight@g.ncu.edu.tw> <CAJuUDwtyf_TdGR34oKmLRgRU_jy+JtUSmSt1v_j20e+BwrfA7A@mail.gmail.com>
From: Alexander Aring <aring@mojatatu.com>
Date: Mon, 11 Sep 2017 08:47:17 -0400
Message-ID: <CAOHTApj2tkJ7Xju0LSYrgz_uDsR2L35j+QvXswXgnCRkdqHMKA@mail.gmail.com>
Subject: Re: [PATCH] linux-wpan: Add an IEEE 802.15.4 over LoRa Semtech
 SX1276/77/78/79 device driver
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Xue Liu <liuxuenetmail@gmail.com>
Cc: Jian-Hong Pan <starnight@g.ncu.edu.tw>, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>, devicetree@vger.kernel.org

Hi,

On Mon, Sep 11, 2017 at 3:50 AM, Xue Liu <liuxuenetmail@gmail.com> wrote:
> Hello Pan,
>
> From my point of view, it is not a good idea to write sx127x driver
> for IEEE 802154. Because LoRa is not compatible with IEEE 802.15.4 in
> PHY and MAC layer.
>

This isn't true. The security layer is exactly the same and copied
from IEEE 802.15.4.
The rest of the mac layer is pretty simple. Simpler than IEEE
802.15.4... for now.

> I think it is better to make individual Phy and MAC layers for LoRa in
> Linux kernel, where a sx127x driver will make sense.

What about to introduce a new interface type? Then you can do a
complete different parsing on this interface type and share the code
what you need from 802.15.4

- Alex
