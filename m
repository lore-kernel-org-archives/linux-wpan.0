Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D192C433FE
	for <linux-wpan@archiver.kernel.org>; Fri, 21 Oct 2022 12:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiJUMOJ (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 21 Oct 2022 08:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJUMOJ (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 21 Oct 2022 08:14:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF46125F8DA
        for <linux-wpan@vger.kernel.org>; Fri, 21 Oct 2022 05:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666354446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BmP2EzhkN5GrjwIhgKrAETHQ4mZOwL2BA16MxU9BY10=;
        b=SGkV9Ki1RmxQb6nmHg44HwKmgDmz2/YK/Fd/jzQFeq/o4Bbvl9ETrxJ8F/H67F/lbzIQlA
        qZmALhukaEVz6sRMtrYd1A84IlX7tS1cQZJzik14r6NpbT672Wjcpkh2DT4PDPwRpjkURR
        SJfK8P9lYtoLGZtEYdTF181EzNYsOL0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-539-nLju6ZR0Nty_P_rOFO7ahA-1; Fri, 21 Oct 2022 08:14:05 -0400
X-MC-Unique: nLju6ZR0Nty_P_rOFO7ahA-1
Received: by mail-ed1-f69.google.com with SMTP id h13-20020a056402280d00b0045cb282161cso2234735ede.8
        for <linux-wpan@vger.kernel.org>; Fri, 21 Oct 2022 05:14:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BmP2EzhkN5GrjwIhgKrAETHQ4mZOwL2BA16MxU9BY10=;
        b=OB3/Z9pTVj4LP0cqKiN59QZwlYvN/su5ceFdFTzGM0gSiguBFOc5Vw3JYdsl3c1aPX
         bhn/+b5ta3BiHLLR4tOnavs6OAxmoUXvVPf2JFbhLFAH1IvrwDT7N0lMSqavp2i2arNb
         QqkVEjYDupNTJNtltM5iRft2MAdKeGSS97JlIQejRDf5xATJ/cBQysnoPwXlr+4LO8v5
         3+XcYmjUXE0h9dAObXSf8+Ax0IHtM0krxCU0MwrkA/CIYWC4p59iGoh7mqwKt+/1p2XA
         0KR2daB6WVyIjC9GWldFG82F7qKZHgZ/ng77hVSWUdl5IvyppvG1sMR5OYci5wTscMLL
         YB4Q==
X-Gm-Message-State: ACrzQf1oCZlkCfMi3VdIg6mB1oHOlV+p7042gOAj01F5ZJe1rtPmyhvS
        ZsWXMQ6GnEOJ6+/WZyGCuWmGdA28QE18tSP1Mg/29siXaZlI2/HIDoD/E4Nn2N9Eqqhi7hqY6fY
        tdiBClWusZ1U+1m3MnoSUvcmw7mjfmJoQt/czIg==
X-Received: by 2002:a05:6402:5409:b0:44f:1e05:1e8 with SMTP id ev9-20020a056402540900b0044f1e0501e8mr16923323edb.373.1666354444507;
        Fri, 21 Oct 2022 05:14:04 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5lsEEH+5kwAPMzKMi0VFuLOXCtsHrq+YLcgnYumLJhEPvahbbUjFaoripbOmW4XqRo0AfuX7JYv45B1775rsg=
X-Received: by 2002:a05:6402:5409:b0:44f:1e05:1e8 with SMTP id
 ev9-20020a056402540900b0044f1e0501e8mr16923311edb.373.1666354444345; Fri, 21
 Oct 2022 05:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220906082104.1338694-1-miquel.raynal@bootlin.com>
 <20220906082104.1338694-2-miquel.raynal@bootlin.com> <44a98eb6-e8bb-3065-4c6d-9ffb801182ae@datenfreihafen.org>
 <20221014081808.1b30bba7@xps-13> <CAK-6q+jbAmTYfF8OTZNZ-KdUNWAfU2RRJE7p8N6nMyHB0xwGMg@mail.gmail.com>
 <20221019214625.22101769@xps-13> <20221020161713.6004b0cf@xps-13>
 <CAK-6q+iffiLx0U3W0Gaw=xtDn3ipRb5v5BPKEazxfpe343h5iA@mail.gmail.com> <20221021085353.2ad567d4@xps-13>
In-Reply-To: <20221021085353.2ad567d4@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Fri, 21 Oct 2022 08:13:52 -0400
Message-ID: <CAK-6q+g6mDWh2xNmMUviqiiDwBs1q835TrOU9wZ-CF7=rOA+Tw@mail.gmail.com>
Subject: Re: [PATCH atusb/fw v2 2/3] atusb: fw: Update toolchain instructions
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Stefan Schmidt <stefan@datenfreihafen.org>, werner@almesberger.net,
        Alexander Aring <alex.aring@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-wpan@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Fri, Oct 21, 2022 at 2:53 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
...
> I read a little bit more about LQI during this test phase and indeed,
> "weak" seems appropriate :-)
>

* "weak" defined.

> > I heard successful reports also using aluminium foil around transceivers...
>
> Indeed I've heard it could work, I'll keep it in mind!
>

be careful with shortcutting something there, for atusb I recommend [0].

- Alex

[0] https://www.thingiverse.com/thing:2815832

