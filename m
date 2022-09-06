Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6F3ECAAD3
	for <linux-wpan@archiver.kernel.org>; Tue,  6 Sep 2022 00:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbiIFATr (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 5 Sep 2022 20:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiIFATp (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 5 Sep 2022 20:19:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063A51261F
        for <linux-wpan@vger.kernel.org>; Mon,  5 Sep 2022 17:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662423583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/uBWLt2Qq8lEJpMJtDpdhrDxVNiqQlzslVCubDCVrmA=;
        b=caiTkrYGjk/Bp6ApzD728twdZ0/AbpzdcgbfNoQvp8cJm6SJ28c5tvUaBTGp+fB/M1jMH9
        Q0SK89xltEezifRKriLToQPZhnq27Hbw8ajLPaxwBEG029/lSYOZZH/YBgyvSGxTSXqSzN
        nmZXe1PMwSfOgODOS8Cc2eELy9EyOWg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-32-f0zNv1C0NDKcSUhQfjUIWg-1; Mon, 05 Sep 2022 20:19:40 -0400
X-MC-Unique: f0zNv1C0NDKcSUhQfjUIWg-1
Received: by mail-qv1-f69.google.com with SMTP id u4-20020a0c8dc4000000b00498f6359b6dso6656765qvb.17
        for <linux-wpan@vger.kernel.org>; Mon, 05 Sep 2022 17:19:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=/uBWLt2Qq8lEJpMJtDpdhrDxVNiqQlzslVCubDCVrmA=;
        b=l8w1lOfK6PtRvJ444wJ1Z/utApBgxLWY/99XCsLYSD3AdHG1RfSvS+aCo4r7BxGszi
         O07d7zDaeb7qYmH1a1GhF8BQLH+XVFtMWxlPXdELYsR6L73khL5YG17sDzgCLwmmxfG3
         1k/uKcFooShIQx/GkAkdYehNbR9vdc/LYjgPQImhDwk26tweOMyBdBAGQEXLPlmUHUBt
         oM8o0eQpv2ouo2D51WGLBorxWHkmhXVMAt28UhfQXzy8g1bIeqNSakS/AIdlk0sFiQvv
         Gbf9wMXwRvNV6IleY2+MwSSfSmmg43RRehod7TwbvteSg6NoPmAtODl2cKwaF36RoLL+
         9BHQ==
X-Gm-Message-State: ACgBeo3jxKnZAP9vL5R9gqWhEhYxwErKYklS5eF96XJUoJqrTLHsiNrA
        ymhzxt40QfRFfk/tzTyd+FJm6krkwuDuhT9AIKWJ9jMfACjRdW2aGN0hgKEPsQmXsbuzYjvu6Yk
        le5EljByvPzugX73rSlXoUFWBUuuWu9Psk1sdFw==
X-Received: by 2002:a05:620a:2908:b0:6bb:5c2b:4226 with SMTP id m8-20020a05620a290800b006bb5c2b4226mr34034344qkp.27.1662423579635;
        Mon, 05 Sep 2022 17:19:39 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6lKERcNbjPOYJ6ZIE7IdcijOu4CTlKaaKSP8rSWfy3YttfUDdn6u32yt7usN9KSboUXCA5wRR+mUwW92EGuHA=
X-Received: by 2002:a05:620a:2908:b0:6bb:5c2b:4226 with SMTP id
 m8-20020a05620a290800b006bb5c2b4226mr34034332qkp.27.1662423579469; Mon, 05
 Sep 2022 17:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220905204318.1324284-1-miquel.raynal@bootlin.com>
 <20220905204318.1324284-2-miquel.raynal@bootlin.com> <CAK-6q+jXWgEbZ_2kyOh-Jh4N1+d6owMbRn0e637MPMt+3+779g@mail.gmail.com>
In-Reply-To: <CAK-6q+jXWgEbZ_2kyOh-Jh4N1+d6owMbRn0e637MPMt+3+779g@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 5 Sep 2022 20:19:28 -0400
Message-ID: <CAK-6q+jdrk+5STNapcb=WX3vi8T-ucMSj3KDi8yB2WjGd93moQ@mail.gmail.com>
Subject: Re: [PATCH atusb/fw 2/2] atusb: fw: Provide TRAC status
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     werner@almesberger.net, Stefan Schmidt <stefan@datenfreihafen.org>,
        Alexander Aring <alex.aring@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Mon, Sep 5, 2022 at 8:16 PM Alexander Aring <aahringo@redhat.com> wrote:
>
> Hi,
>
> On Mon, Sep 5, 2022 at 4:43 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >
> > From: Alexander Aring <aahringo@redhat.com>
> >
> > Upon Tx done condition, returning the sequence number is useful but we
> > might also return the TRAC value which is needed to ensure that the
> > packet we sent got ACKed. The TRAC register just needs to be read when
> > the TRX_END interrupt fires.
> >
> > We then need to send this information as part of the status
> > message. First byte remains the sequence number for ensuring backward
> > compatibility and a second byte is added to forward the TRAC register
> > status.
> >
> > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> > [Miquel Raynal: Moved the data array out of the stack, wrote commit log]
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>
> I sent another patch v2, it should also fix a race see commit msg
> regarding RX_AACK_ON. May you can fast test it and feel welcome to
> resubmit it as a patch.
> This patch has a lot of generated/compiled files added and I think it
> was an accident.

there are files which need to be added to ".gitignore". Just a hint,
run "git add -u ." instead of "git add ." which will not add new
files.

- Alex

