Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A309DC43334
	for <linux-wpan@archiver.kernel.org>; Mon,  4 Jul 2022 01:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiGDBSH (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 3 Jul 2022 21:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGDBSH (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 3 Jul 2022 21:18:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFBE96274
        for <linux-wpan@vger.kernel.org>; Sun,  3 Jul 2022 18:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656897484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rBcId0LsMiJ8kchATAtPUDOo18oCzMowzraY14qwnJc=;
        b=Nm939Zg2g7jPE12N+20Yi4oMeHsEZapdPqAtkpAH5DTeXD9AvYzOHTFnQtsZYHXqaCDZdf
        VpnUCNzocyiESYJcvEWWF/zbq8jb88FrKWFONTa9f+jkq4+BmURV6zDDlt4ngoL1CdikEB
        uX/AChRlk444HU63hfX8AGcBJw9krwU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-119-VFiVIDVEMPu4h3ug922lCw-1; Sun, 03 Jul 2022 21:18:03 -0400
X-MC-Unique: VFiVIDVEMPu4h3ug922lCw-1
Received: by mail-qt1-f200.google.com with SMTP id e14-20020ac8010e000000b00316edc1a792so5573920qtg.18
        for <linux-wpan@vger.kernel.org>; Sun, 03 Jul 2022 18:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rBcId0LsMiJ8kchATAtPUDOo18oCzMowzraY14qwnJc=;
        b=7lgkcTHRHC8JzG4yZv5YNRxs+DlP8OROUV+3gfvJfM+KW9l2+UPe0SB1e4gtIzKBZS
         mh6zGuVlV96L1aFXNvRbmhE1CmntdvNbzD90clZ+h+rkW78Cd4AEeEyvOYhm4Gf0FAMK
         BhbHEkMVulXD6BdNWBFjGhC8saV7P2nPwvUqWCDzzCqZ5ZtwTwIqNQmDxgU9VKpv4XuG
         pPbbVQ7piI7v3ol/WaeZnObHcxM1FKdSxxPXVWfDRlWyt76V4sDwWOEwdaBBzWi03Hvt
         36EqulkOwWMZjBxxVx02MkUkFfYiQsYKfkgjeC6Bq/5QdwZ2LS6+pppnFtF7UQFKGfuD
         4rNA==
X-Gm-Message-State: AJIora9JRPTPY8G+rCvAxf8H+oCbgQ7kOwn0sIuRj7ijWEodAYxks/zX
        XPePhCJFc5mkFmbuz6oqOssImDHB5zCOwpLirW2qof7CHeI0GLcgkGodFazGX3SLIFzTMvytPII
        VClS14/GteAiWhw6SLpKwhn63jhLnEkEoA9RaOw==
X-Received: by 2002:a05:622a:1306:b0:31a:f73e:3d6d with SMTP id v6-20020a05622a130600b0031af73e3d6dmr22388487qtk.339.1656897482818;
        Sun, 03 Jul 2022 18:18:02 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1syz7xlfqoZFtm72jwtXJn8D6qO7f/i/zDerAeST5FMthivoVI/zdvKXb8JZXdbJyaIYsR2AWLIwVq1jSH/Yvc=
X-Received: by 2002:a05:622a:1306:b0:31a:f73e:3d6d with SMTP id
 v6-20020a05622a130600b0031af73e3d6dmr22388477qtk.339.1656897482655; Sun, 03
 Jul 2022 18:18:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220701143052.1267509-1-miquel.raynal@bootlin.com>
In-Reply-To: <20220701143052.1267509-1-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sun, 3 Jul 2022 21:17:51 -0400
Message-ID: <CAK-6q+jxyRVc=qwWQfhnnzOFOny5cp=eAn_pz_4_=NbK-NY5Eg@mail.gmail.com>
Subject: Re: [PATCH wpan-next 00/20] net: ieee802154: Support scanning/beaconing
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Network Development <netdev@vger.kernel.org>,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Fri, Jul 1, 2022 at 10:36 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hello,
>
> After a few exchanges about inter-PAN management with Alexander, it was
> decided that most of this series would be dropped, because the kernel
> should in the end not really care about keeping a local copy of the
> discovered coordinators, this is userspace job.
>
> So here is a "first" version of the scanning series which hopefully
> meets the main requirements discussed the past days on the mailing
> list. I know it is rather big, but there are a few very trivial patches
> there, so here is how it is built:

I have probably more to say about this patch series, but I need more
days to look into it closely. So maybe we can first discuss here more
about things I comment on and have questions about it.

Thanks.

- Alex

