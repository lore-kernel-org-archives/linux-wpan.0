Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F17E784A6
	for <linux-wpan@archiver.kernel.org>; Sun,  1 Oct 2023 23:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjJAXfA (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 1 Oct 2023 19:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjJAXe7 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 1 Oct 2023 19:34:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA527BD
        for <linux-wpan@vger.kernel.org>; Sun,  1 Oct 2023 16:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696203250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DwJG0Y5sytb0MznGWtUDKTAoJSwDn3GmQx41e5AajOU=;
        b=fQzFoFr9Y9g3jBbImtKn60dMUQpFP2HYtwxP9CEMMHPxtWB/0BRP3pYTNfTO7qcF7zytkf
        IFxCLrSaBCtUa2TwOhaCiYIcPuq+vGDFc6QkR+qfscGIqgbZ+3aOXouYO26A+4WpTKRj6B
        q0KqeZLaex12LU2ZGeFU86G+bkZU1qY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-NxgSRPlxMQebyw-ja8sMLQ-1; Sun, 01 Oct 2023 19:34:08 -0400
X-MC-Unique: NxgSRPlxMQebyw-ja8sMLQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9a62adedadbso1365009466b.1
        for <linux-wpan@vger.kernel.org>; Sun, 01 Oct 2023 16:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696203247; x=1696808047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DwJG0Y5sytb0MznGWtUDKTAoJSwDn3GmQx41e5AajOU=;
        b=F3cosfWu2zz3bEWTMJ53vj3TTjiqQCaGUY5sMb6mp0vOQRyoJaCrGlCpEbiteQdl1B
         bRjjMedzR/lE0bwZQLlYaScqyw7vcbNfENrm0h9SCrcZ4zOyuskYtZr0re72pRxdVzrZ
         ionX5kJAUPagWKuiFS/xtn6J7bTmRMdBBtVPTZufsSHSX/oQC+amndoGvCs7gh/3hswV
         JNYsvgUlCSczg1wNcr2PzO4M4G66Y0ROytsvs0J5c3JhP5KmbAVMDi199HFXv7ahLE7g
         xOTeC1DCEfGVNgEAGEV1JEIBGXvnKzlm8EYSoES7ztmC6RHEdxOW+iog41qFWinFgmUc
         H0SA==
X-Gm-Message-State: AOJu0Yy5FxEy2UTTGa6glqnoeaQFhhY/SuWuj0LX13ivnEHoQrUx+sZR
        I6n8upDGTVfdKSLBtXPReKcblESW95RtKg8nOAH9d3PI5kcqI7LSY3K0e+Z/HtHUuDFmslfKtL4
        yksCa4jme9CFduZpte+8b3LTGJCnAhrHZnqvI0A==
X-Received: by 2002:a17:906:20d6:b0:9ae:7870:1522 with SMTP id c22-20020a17090620d600b009ae78701522mr8658791ejc.53.1696203247567;
        Sun, 01 Oct 2023 16:34:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExngVT5wUc9C0is6PUWQbq2ldP0VG2ft4oj5HXM6EHGFaOnukOgCOH0ZffGNERSSTq/pQrTSBMYaDux+eHC5c=
X-Received: by 2002:a17:906:20d6:b0:9ae:7870:1522 with SMTP id
 c22-20020a17090620d600b009ae78701522mr8658786ejc.53.1696203247299; Sun, 01
 Oct 2023 16:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230924122231.716878-1-stefan@datenfreihafen.org> <20230924122231.716878-6-stefan@datenfreihafen.org>
In-Reply-To: <20230924122231.716878-6-stefan@datenfreihafen.org>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sun, 1 Oct 2023 19:33:55 -0400
Message-ID: <CAK-6q+gsfJqyNUGsyuQkk=b4eTBEEJ_SHEaXLqz7jrr_6bEu8Q@mail.gmail.com>
Subject: Re: [PATCH 5/9] src/nl802154.h: switch file to SPDX header for
 license and copyright
To:     Stefan Schmidt <stefan@datenfreihafen.org>
Cc:     linux-wpan@vger.kernel.org, alex.aring@gmail.com,
        miquel.raynal@bootlin.com, david.girault@qorvo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Sun, Sep 24, 2023 at 8:24=E2=80=AFAM Stefan Schmidt
<stefan@datenfreihafen.org> wrote:
>
> This file has its own commit as we are syncing it between the Linux
> kernel and this project when new netlink functionality is added.
>
> The same change needs to be done on the iLinux kernel side as well to
> avoid conflicts.
>

the iLinux kernel? :) The Linux fork running on an iPhone?

It's okay... you don't need to fix it.

- Alex

