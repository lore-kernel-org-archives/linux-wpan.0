Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CFEC77B73
	for <linux-wpan@archiver.kernel.org>; Tue,  6 Jun 2023 09:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbjFFJvx (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 6 Jun 2023 05:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjFFJvw (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 6 Jun 2023 05:51:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36286E76
        for <linux-wpan@vger.kernel.org>; Tue,  6 Jun 2023 02:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686045072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=38AKLlfRzFfzbHumACWesn62Y/isbifhTQ7f9ujx0kg=;
        b=Np8RcoalX+EoHxelUxM5a8lQlT8rgQvF/7RPrwMqnppSiE80A1Cdb0Z/DpQHOzk4lArorn
        NU4/mtoQSNZ8lRF2Xsnon5UbVDYQfHD3oKX/gyPfVEEsRzKUDVX0sESEmKwbnzb8uAl36u
        /iO7PgXbDZFK7CKgqPq91V2u3GRg+ps=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-vhYzZ2rNMkWGlEtm54EJRw-1; Tue, 06 Jun 2023 05:51:11 -0400
X-MC-Unique: vhYzZ2rNMkWGlEtm54EJRw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-977cb78acfcso204922066b.3
        for <linux-wpan@vger.kernel.org>; Tue, 06 Jun 2023 02:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686045070; x=1688637070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38AKLlfRzFfzbHumACWesn62Y/isbifhTQ7f9ujx0kg=;
        b=ZaHxp37H0g3EjScj5xb+K0YWtaNeZzSE8uYvcqpFWBq5rt5myo+NAYqdj4fcg2L0z/
         uzD9i6443GvuEcCB62sl583AMNdO7I8f0IvCMr2gohPbvuCCegecD/es8Kyf8LQPQ6Iq
         /yEfdqUTdn2a3J6YICx+0e8aNnseB/VHjC5mjsMkjpJvaBLEa218nHuR+zV0FEcJ28BX
         8TzOCXxx/OjV71xykyLONfABY2r54qo4A1davOYeqOUanu3dXMvSv5L7f5Iq2OQH60a2
         BcQL3fyhNSTnpjaWNzXQ8OKR4drMAppbw2QFfpHf3+O/RUc6p3cDq9Y6sXkKqq02uhm6
         0NUA==
X-Gm-Message-State: AC+VfDypczXQJ3hiKcVa9q+0kWuBmagnTmd3iguqL4rCcQS42Kidexc2
        slMje2/jKTaR73JPBCKTgJFsDn6g2EZfiatNsD5Bkfy/tSVdxf9k1jTZVa5PrVnQwIcecFuaTnX
        divHRb1a7Jn8S2Kmx7rJlfA5LQIl5SNFWodjUEw==
X-Received: by 2002:a17:907:7da5:b0:976:b93f:26db with SMTP id oz37-20020a1709077da500b00976b93f26dbmr1746053ejc.53.1686045070071;
        Tue, 06 Jun 2023 02:51:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Dv3AJpDlVEjRtuKVJHJ8H8bJ9LrW98cfd9HvqCm7NXhOTBDEvR3sZYKUjCUGJsG8TnUKUHFJh/2NwjIVZfoA=
X-Received: by 2002:a17:907:7da5:b0:976:b93f:26db with SMTP id
 oz37-20020a1709077da500b00976b93f26dbmr1746034ejc.53.1686045069784; Tue, 06
 Jun 2023 02:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230528140938.34034-1-andriy.shevchenko@linux.intel.com>
 <ZHWo3LHLunOkXaqW@corigine.com> <ZH3srm+8PnZ1rJm9@smile.fi.intel.com>
 <CAK-6q+hkL8cStdSPnZF_D1CtLvJZ=P16TJ8BCGpkGwrbh8uN3A@mail.gmail.com> <20230606114743.30f7567e@xps-13>
In-Reply-To: <20230606114743.30f7567e@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 6 Jun 2023 05:50:58 -0400
Message-ID: <CAK-6q+hoNTZFyg6cGDHmJYV+mw17AgJ6EEkgDz=qrNa3pkmtrw@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/1] ieee802154: ca8210: Remove stray
 gpiod_unexport() call
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Simon Horman <simon.horman@corigine.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Aring <alex.aring@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Miquel,

On Tue, Jun 6, 2023 at 5:47=E2=80=AFAM Miquel Raynal <miquel.raynal@bootlin=
.com> wrote:
>
>
> aahringo@redhat.com wrote on Tue, 6 Jun 2023 05:33:47 -0400:
>
> > Hi,
> >
> > On Mon, Jun 5, 2023 at 10:12=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Tue, May 30, 2023 at 09:42:20AM +0200, Simon Horman wrote:
> > > > On Sun, May 28, 2023 at 05:09:38PM +0300, Andy Shevchenko wrote:
> > > > > There is no gpiod_export() and gpiod_unexport() looks pretty much=
 stray.
> > > > > The gpiod_export() and gpiod_unexport() shouldn't be used in the =
code,
> > > > > GPIO sysfs is deprecated. That said, simply drop the stray call.
> > > > >
> > > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com=
>
> > > >
> > > > Reviewed-by: Simon Horman <simon.horman@corigine.com>
> > >
> > > Thank you!
> > > Can this be applied now?
> >
> > ping, Miquel? :)
>
> I already applied it locally, but I am trying to fix my "thanks for
> patch" routine to not tell you it was applied on the mtd tree :-p

okay no problem. Fully understandable as we have a new workflow
mechanism for 802.15.4.

Thanks. :)

- Alex

