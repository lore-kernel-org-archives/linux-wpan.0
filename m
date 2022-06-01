Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451D2C433F5
	for <linux-wpan@archiver.kernel.org>; Wed,  1 Jun 2022 03:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349422AbiFADap (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 31 May 2022 23:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349446AbiFADam (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 31 May 2022 23:30:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64E459CC8E
        for <linux-wpan@vger.kernel.org>; Tue, 31 May 2022 20:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654054238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Uez4pdd6rTNByI07DHPT6nt3P15ulK/dmFK17elfDS8=;
        b=Io+4xV09eqsdfzLKIbwvOw6AQ1Fj2rneM1QtO/IOnRtS1ELBCNslgfw+YJLnm5sZYcTO2A
        ufe/tmBE3dZ0byc60ZJfnj2es7IFSEOdujKr1GzRwQsAaj2w1urKXx8l7zYt23QTZS2JLy
        IBuOL+Ut1Kr0Vb5XpU3bFOFZo4W/vzA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-iA3akX-wO12w8uNajBFb5w-1; Tue, 31 May 2022 23:30:37 -0400
X-MC-Unique: iA3akX-wO12w8uNajBFb5w-1
Received: by mail-qv1-f72.google.com with SMTP id ke5-20020a056214300500b00461fc78b983so509566qvb.17
        for <linux-wpan@vger.kernel.org>; Tue, 31 May 2022 20:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uez4pdd6rTNByI07DHPT6nt3P15ulK/dmFK17elfDS8=;
        b=YvsdawW8r8TSIwvjTlFZogJQDmxTAYmcFzbnj+R6YidyC8BtASHznfp0QBlM8cPLVT
         mMZMk///UHUtRznq4Jrtrqa8IsGbkyvh1GhkYTlqj2LntQerPreQPQk5akHZUcd5A9Sl
         hnxAs+OT7gIg9TpWakAim7DP8/5+bo3EF4mqz4GsgJSALPWHgTKs3K30wu8KjSdJEQ5V
         eNXdbfHnMBj0Y10znMzXb5AeGJ9ls32z5frA/j4oxYe9enUOVT8AGRjFZDaydMeKF9y2
         d6wc8+edytAK0uDUxI+j2uYHjkFvZkkrmlpqiL7FS0LiugjXdik75LGuBMMHblszyWqG
         QZeg==
X-Gm-Message-State: AOAM533RvpY/97oQAO3HWR9E5a3TfZ+wHsrrrLcYi7TgY3qo4sLKqjaf
        zPUkkbJ9P23cPAQ0BV+w/DjbyGRwr1eWLJvfgOXRipDOv8L7yK28FogsltP6JoFLi6ygNUQsWGj
        JwKgUvkyEG160xOsw7nhwOoLEFhDBkqarCWBqBQ==
X-Received: by 2002:ac8:5a82:0:b0:304:c138:9895 with SMTP id c2-20020ac85a82000000b00304c1389895mr2893552qtc.470.1654054236982;
        Tue, 31 May 2022 20:30:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmL0YAluv459XcSBEPJSIe71phqGVQHBoIyR7YZoUQlxcpz3e0vsJ8mQlBCbKPaoJGLQR7yyMdg4YqTTsxkcs=
X-Received: by 2002:ac8:5a82:0:b0:304:c138:9895 with SMTP id
 c2-20020ac85a82000000b00304c1389895mr2893543qtc.470.1654054236821; Tue, 31
 May 2022 20:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220519150516.443078-1-miquel.raynal@bootlin.com>
In-Reply-To: <20220519150516.443078-1-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 31 May 2022 23:30:25 -0400
Message-ID: <CAK-6q+hmd_Z-xJrz6QVM37gFrPRkYPAnyERit5oyDS=Beb83kg@mail.gmail.com>
Subject: Re: [PATCH wpan-next v4 00/11] ieee802154: Synchronous Tx support
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Thu, May 19, 2022 at 11:06 AM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Hello,
>
> This series brings support for that famous synchronous Tx API for MLME
> commands.
>
> MLME commands will be used during scan operations. In this situation,
> we need to be sure that all transfers finished and that no transfer
> will be queued for a short moment.
>

Acked-by: Alexander Aring <aahringo@redhat.com>

There will be now functions upstream which will never be used, Stefan
should wait until they are getting used before sending it to net-next.

- Alex

