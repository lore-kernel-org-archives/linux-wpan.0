Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7212DC6FD20
	for <linux-wpan@archiver.kernel.org>; Fri, 24 Mar 2023 13:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjCXN6G (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 24 Mar 2023 09:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjCXN6F (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 24 Mar 2023 09:58:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9E0166C3
        for <linux-wpan@vger.kernel.org>; Fri, 24 Mar 2023 06:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679666231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xvcJNrPQD5ooFYZurkB3yN9PFKDKP+vxBqfGV/npfuk=;
        b=RSfMyDezSott8s1wkJWliTGwaB9MW4aIrfZWJ7OpxcwKNuppvBzsmq5gqN2kbDpWPRuHpd
        6+4ftO4S5D0Qi4EDADJQ6iJb1bft9V7BBloz3o6HpzNYoV5+pGTHcjzCDhrY/Hp9sv5kTa
        qPiDoLH77vz4ptMjOUwtxVQkGdN0IIs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-ZTJfhWJFPJudLpwrRtyLYg-1; Fri, 24 Mar 2023 09:57:10 -0400
X-MC-Unique: ZTJfhWJFPJudLpwrRtyLYg-1
Received: by mail-ed1-f71.google.com with SMTP id p36-20020a056402502400b004bb926a3d54so3319829eda.2
        for <linux-wpan@vger.kernel.org>; Fri, 24 Mar 2023 06:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679666229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvcJNrPQD5ooFYZurkB3yN9PFKDKP+vxBqfGV/npfuk=;
        b=eoDa44v1vP+TGmk0mjBy2nL35iBDImAXFF4ViIqoLNF7B+v7Lgp2NrQLw36Jl11Ney
         KT2B5Sw2hjvEVnPh/ry4TPBHmCLEVZ7mxkAiEuuSVLavyQHgRCjG1WmtdD8Mr9ZlzkVT
         J8PEeBYZsArr8uxo19JmoSGhay4IoJsOnelPH3p7ZPgvCLit7MbEtVJLgNjffMXEdG/6
         zu0qCem63/cRH/0BmZ0xN0bZ7CnpS8tA1OIu/k8pgbDuNs+RgsnfnGIhDNbAjjSm9Er+
         4whM0JX4NDxMajX8wvathTAvDtWwLiwUNPI/wDQSPNRzYZ96TIu93V8LWXOqU/o5B9rb
         tM6A==
X-Gm-Message-State: AAQBX9ek9A0Z+dTm1dX+tUB0C5pSBEbui+vuhYc/OY5bWou+qLdF/NDe
        Eyquc12QW4+r3V5lojOQ15xi1EJ0eqQvAwz0c79KHbJ66X3DY2e6ZtGezd6DWtEya0R02Cw7eo/
        s9pQNSNjfjGeK/cue4VESbV4+6QAt0uPHwQZ98A==
X-Received: by 2002:a50:f69e:0:b0:4fc:8749:cd77 with SMTP id d30-20020a50f69e000000b004fc8749cd77mr1542601edn.3.1679666229223;
        Fri, 24 Mar 2023 06:57:09 -0700 (PDT)
X-Google-Smtp-Source: AKy350bigzFWO3HLR1wBXdAmOWSmDdssXZvyhIoU+omNqJjNe4otSNeDTt3p1Ckx8dJADayo4lhlv4HE3l9QBDb44aI=
X-Received: by 2002:a50:f69e:0:b0:4fc:8749:cd77 with SMTP id
 d30-20020a50f69e000000b004fc8749cd77mr1542584edn.3.1679666229026; Fri, 24 Mar
 2023 06:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230324110558.90707-1-miquel.raynal@bootlin.com>
In-Reply-To: <20230324110558.90707-1-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Fri, 24 Mar 2023 09:56:57 -0400
Message-ID: <CAK-6q+gzwOFbpN4JfYdfUzmVfeF+YzNwamkEaF-gYeMY8bzNww@mail.gmail.com>
Subject: Re: [PATCH wpan-next 0/2] ieee802154: Handle imited devices
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

On Fri, Mar 24, 2023 at 7:07=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> As rightly pointed out by Alexander a few months ago, ca8210 devices
> will not support sending frames which are not pure datagrams (hardMAC
> wired to the softMAC layer). In order to not confuse users and clarify
> that scanning and beaconing is not supported on these devices, let's add
> a flag to prevent them to be used with the new APIs.
>

Acked-by: Alexander Aring <aahringo@redhat.com>

I appreciate that you care about driver specific quirks which need to
be done here. The users of this driver are getting aware now there is
a lack of support here.

Thanks.

- Alex

