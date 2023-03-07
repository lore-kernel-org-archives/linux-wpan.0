Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7044C64EC4
	for <linux-wpan@archiver.kernel.org>; Tue,  7 Mar 2023 00:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjCGAHf (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 6 Mar 2023 19:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjCGAHe (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 6 Mar 2023 19:07:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321955708F
        for <linux-wpan@vger.kernel.org>; Mon,  6 Mar 2023 16:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678147610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kiG8BgPH1QQ43j7yve5gAvlmd9pWIcu5Uac1q0tt6sI=;
        b=ZWUsa1p9uswvCSP5TTcJ9k/fUb4G2oDPgFhqrIRY8g2i2AV0nSuoRukNEbgxiav5l3F0kT
        kRG0pGqLsZ/wFh7JrjcLK5CFDb7quWSCo8O7MTt6MhYdjucEULszygO0ZlVr14VDpzLn1Z
        Fy8Zr2/LXcvdOPDfBPqzFqfkhAN4nTY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-DnNehCj3NpCzfXne4Ox2bA-1; Mon, 06 Mar 2023 19:06:46 -0500
X-MC-Unique: DnNehCj3NpCzfXne4Ox2bA-1
Received: by mail-ed1-f72.google.com with SMTP id r9-20020a05640251c900b004d4257341c2so10458118edd.19
        for <linux-wpan@vger.kernel.org>; Mon, 06 Mar 2023 16:06:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678147602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kiG8BgPH1QQ43j7yve5gAvlmd9pWIcu5Uac1q0tt6sI=;
        b=6tOL4n4AXFQzuxcq7Nmu8E8YQJ3YU3RFo5TNOjL/OfAScIE8TAyECYbBrc64uN7gw+
         TwIT6kkhyiIvmnBWNeXJcykS+L+1iA2kSpGzWPepbdC4C/n+e2GnCbdX5aPqf+oGa2Ys
         9LJY3qCJygRz2PThqrgQ2XcoNbt5HqM4+K4Z5ldLxzd/nFFwa6huTgkUJqMR31pDAUF8
         wYWe3OQ10e2lHIh5Mu3wucO3octqnA0Us4B0dTG7VNum7rwfHObbvFwgPmFzzcug1mV6
         GcPm026DCdlp6HaEq6RLA0zRKuQfaJK6xKPOeuPrJMGDrwYqsSZsbEQgH1N/yHE1LGik
         8QXQ==
X-Gm-Message-State: AO0yUKV8B+exoNPk6JTfo4WSgPENLAWiuQpCJMtfChSMNG4bB2+XSlDZ
        tjOACikLyY2sEq7YWYC3ncCHW0j1FUZ/uEjn5WP9ft+N9Qnwzxcw7mY4Ita9uDxJXxmqUPVtX2X
        GbRzGbjiEkIqPxCJPnz2Eg+aluRAlW5q/ph+eNg==
X-Received: by 2002:a17:906:338e:b0:895:58be:963 with SMTP id v14-20020a170906338e00b0089558be0963mr6262955eja.3.1678147602617;
        Mon, 06 Mar 2023 16:06:42 -0800 (PST)
X-Google-Smtp-Source: AK7set+tlZyOLrVQtITvkM4aCSQgfCcDyTdnBcxy/a9AwJHlmGApYotDt8QLwad83Q2rJffmtyK+Fiuv9O7gGylkK+s=
X-Received: by 2002:a17:906:338e:b0:895:58be:963 with SMTP id
 v14-20020a170906338e00b0089558be0963mr6262936eja.3.1678147602324; Mon, 06 Mar
 2023 16:06:42 -0800 (PST)
MIME-Version: 1.0
References: <20230306191824.4115839-1-harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230306191824.4115839-1-harshit.m.mogalapalli@oracle.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 6 Mar 2023 19:06:31 -0500
Message-ID: <CAK-6q+iHJouJc2WSuPipC8kieULYg02ipyHaOKDsnj4rT-gcyA@mail.gmail.com>
Subject: Re: [PATCH next] ca8210: Fix unsigned mac_len comparison with zero in ca8210_skb_tx()
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     error27@gmail.com, Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Harry Morris <harrymorris12@gmail.com>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Mon, Mar 6, 2023 at 2:20=E2=80=AFPM Harshit Mogalapalli
<harshit.m.mogalapalli@oracle.com> wrote:
>
> mac_len is of type unsigned, which can never be less than zero.
>
>         mac_len =3D ieee802154_hdr_peek_addrs(skb, &header);
>         if (mac_len < 0)
>                 return mac_len;
>
> Change this to type int as ieee802154_hdr_peek_addrs() can return negativ=
e
> integers, this is found by static analysis with smatch.
>
> Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver"=
)
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Acked-by: Alexander Aring <aahringo@redhat.com>

sorry, I didn't see that... Thanks for sending this patch.

- Alex

