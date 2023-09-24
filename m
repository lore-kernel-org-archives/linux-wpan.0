Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B07CE7A8C
	for <linux-wpan@archiver.kernel.org>; Sun, 24 Sep 2023 20:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjIXUni (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 24 Sep 2023 16:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXUnh (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 24 Sep 2023 16:43:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2039DEE
        for <linux-wpan@vger.kernel.org>; Sun, 24 Sep 2023 13:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695588165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+CMK6+D/DgFWvrNdQUdUJNb6VjX8q7HdCwOuehSf+ek=;
        b=gbEDMBMUCXN6mVv9W0QeY/+KHkYueiY/jVlwRXid5kZe2KrFOLle0z72QWOYinAeWmzQIB
        3oRdDkY0avzpmaz3vTM8wQFdieoklLw0i16VXviXWXkn0J6XdgWINbUAz+3u8Wt49tB4fz
        Rh/r1MS8C7YunyOlBaxfgr3gmHJzPc8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-DaqqoxA9MfqsqhItYx76Bg-1; Sun, 24 Sep 2023 16:42:43 -0400
X-MC-Unique: DaqqoxA9MfqsqhItYx76Bg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-52f274df255so12324068a12.1
        for <linux-wpan@vger.kernel.org>; Sun, 24 Sep 2023 13:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695588162; x=1696192962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CMK6+D/DgFWvrNdQUdUJNb6VjX8q7HdCwOuehSf+ek=;
        b=hfdYewfXKuI9C4gj5ajSxte9+LVMGFf4lntAO6/1ni5kk777PEd9eWXxNjklKLTI8g
         hZxDelwm+cI4Hpl8EYBrW3aDNZP6VB4yTbKzlyT9RQ0XXD6X7loL60COMlAJwIwYgaqt
         S+ENVAOY1eHEMkOPEM7gJ79/6O7j7mtt3qZKzS76dxMs2fNZ/Mg5w7j+cZ404h1JOpAE
         SzC3tJll/tub7UWgB8743WbtLyS8aN1nyoevwuuo9doN1sa+901CKOP8yFuPGE1RKw5V
         sjJhQ8fguVw4PAc1ch29g6ZI1Yw2t4yvcvZPA58THgZik2RI8Va4qV48OUBbCNSjcDvS
         mFNg==
X-Gm-Message-State: AOJu0YwQ7hKwFc+Z7unkxE5uA3jijHCW1cbjHB0zCnTh8gHvSu/Qk/G/
        ymKM+xQOZB5+LNpsUff5J7IpNe2kzGnTp3G0I+lHBD19lFz/HjSp509fUqNnp7jVQI+3POMH9M0
        10rdVZhs0hxhgKK+at5IPfn2lRqWPDzBLBqer3w==
X-Received: by 2002:a05:6402:160b:b0:523:37f0:2d12 with SMTP id f11-20020a056402160b00b0052337f02d12mr7496643edv.17.1695588162714;
        Sun, 24 Sep 2023 13:42:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWcMWKTmSN0kfTv00wCDASzN2wCDt8EDegGAnZ0NNKGCiS3pibO67/pkAQnxbR7S/Utqic+SK40DtF1lRCpbU=
X-Received: by 2002:a05:6402:160b:b0:523:37f0:2d12 with SMTP id
 f11-20020a056402160b00b0052337f02d12mr7496623edv.17.1695588162402; Sun, 24
 Sep 2023 13:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230922155029.592018-1-miquel.raynal@bootlin.com> <20230922155029.592018-2-miquel.raynal@bootlin.com>
In-Reply-To: <20230922155029.592018-2-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sun, 24 Sep 2023 16:42:31 -0400
Message-ID: <CAK-6q+i_fVbj3ceMcCA8F-6aRcX2YX8+iMdQSYmQ7FWLNKfP+g@mail.gmail.com>
Subject: Re: [PATCH wpan-next v4 01/11] ieee802154: Let PAN IDs be reset
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Guilhem Imberton <guilhem.imberton@qorvo.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Fri, Sep 22, 2023 at 11:50=E2=80=AFAM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Soon association and disassociation will be implemented, which will
> require to be able to either change the PAN ID from 0xFFFF to a real
> value when association succeeded, or to reset the PAN ID to 0xFFFF upon
> disassociation. Let's allow to do that manually for now.
>

ok. But keep in mind what happens when a device is associated and the
user sets a short address manually to 0xFFFF?

It should be a kind of forced mode of disassociation?

- Alex

