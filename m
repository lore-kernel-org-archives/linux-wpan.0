Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7576C76196
	for <linux-wpan@archiver.kernel.org>; Tue, 11 Apr 2023 12:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjDKMOQ (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 11 Apr 2023 08:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjDKMOM (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 11 Apr 2023 08:14:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A48272D
        for <linux-wpan@vger.kernel.org>; Tue, 11 Apr 2023 05:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681215206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H+LAR+Nh+ywpoqn7HOuJEg1+vlx3eknXKjWPLOIZ+2s=;
        b=WrSeNHt5FN9/pqxip6OMZNZyoxy3x0o3MH13Vd3Ch7Db7aiXsnhSDWpO8GLzg976/oRdoT
        ORRKJ7dPROWhkbSJLhC25qgaNjm0hTKRFKZXAt9Rybu7su+v200P6gJmesH+TuoA/QRm4j
        jRBUnFMhvE6BTDqCsP4RaHosum9rG8g=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-_TKXL5S_PH6H9BKcrRz0kw-1; Tue, 11 Apr 2023 08:13:25 -0400
X-MC-Unique: _TKXL5S_PH6H9BKcrRz0kw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-502761aeb2dso2087942a12.1
        for <linux-wpan@vger.kernel.org>; Tue, 11 Apr 2023 05:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681215204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+LAR+Nh+ywpoqn7HOuJEg1+vlx3eknXKjWPLOIZ+2s=;
        b=S4VcKndUS2qlmAnhckxPvzl7dyBpHJEnsj8MMfQw1xGzeXXGV97hca5G464ffv8zUJ
         fxDsmdrzwOy8QPIhSZddPlSwZLGP6ZDXgm7bW9m1inE/4LOisOBK6HJ9O1WAhvn2ye6P
         HKx8Z4h5d2mkxPm2xEtqGdFJ8HN2dGn3RBJoIZtws0gZCPrnamM+VhCZhaNRu4VvTcdb
         5O/cF4AaTBIkb8QUxQFWiUwvawjDG4rHWdKQznSC/tbHZZbZudooiHdGQaS94tu5iE3J
         liX35Hvo4573dhxRMIdq5z01xVPqJExwNJZYg6zOr8f09E4h8DuRT2R3yLc0LeJ2vi9v
         X3cA==
X-Gm-Message-State: AAQBX9cjkGnvRmChlM/o5n2vFQQBehTPxsoUVvkpKnVsLCBXDPtF5f3B
        gkUhHu/R8uZqRr3GuvO9rvd/zpfrhN0cAMd2uncXOm8g41fxtX3Q9VjFXuLyTAfEVPynOYJxxnk
        dHH/uY+H5WCJNLCVvlEHD2Wkpy0DJeIo7evZQ+Q==
X-Received: by 2002:aa7:dbcb:0:b0:502:233e:af49 with SMTP id v11-20020aa7dbcb000000b00502233eaf49mr11991543edt.4.1681215204278;
        Tue, 11 Apr 2023 05:13:24 -0700 (PDT)
X-Google-Smtp-Source: AKy350ak30ZX/MBd/MO8vDkeMAWQK6PTsACeMUjed7L1rjoJ6tC2eFSQ1+po+0eatykOUssvudG2A7+swQR4Fw5uZRE=
X-Received: by 2002:aa7:dbcb:0:b0:502:233e:af49 with SMTP id
 v11-20020aa7dbcb000000b00502233eaf49mr11991530edt.4.1681215204013; Tue, 11
 Apr 2023 05:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230411090122.419761-1-miquel.raynal@bootlin.com> <20230411090122.419761-2-miquel.raynal@bootlin.com>
In-Reply-To: <20230411090122.419761-2-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 11 Apr 2023 08:13:12 -0400
Message-ID: <CAK-6q+gNq_dX0_EVrc1Sa8OxBUCFV6hpqmMokLiBbRLDUzXiMg@mail.gmail.com>
Subject: Re: [PATCH wpan-next 2/2] MAINTAINERS: Add wpan patchwork
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Tue, Apr 11, 2023 at 5:03=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> This patchwork instance is hosted on kernel.org and has been used for a
> long time already, it was just not mentioned in MAINTAINERS.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Acked-by: Alexander Aring <aahringo@redhat.com>

Thanks.

- Alex

