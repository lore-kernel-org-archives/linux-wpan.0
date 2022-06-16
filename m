Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3891BC43334
	for <linux-wpan@archiver.kernel.org>; Thu, 16 Jun 2022 13:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbiFPNAd (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 16 Jun 2022 09:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiFPNAc (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 16 Jun 2022 09:00:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC1EE3D1D2
        for <linux-wpan@vger.kernel.org>; Thu, 16 Jun 2022 06:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655384430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e8ZVUkV5slpBiU5gnP3i9vX4TyyFnQAAf/ZHvzAvayg=;
        b=O8vNJrDUOljnba+os4DvV5gvXC11HXMyu7tiYq9yB6GWxbty0SkJwefd4HN/l5qVfNKe6l
        U4/shgckrjFdeWWcOlc8+GyEuT8+Nlac1mJq2bkSnRKkIJnNt3Gpeuwrt/EkkPGofmqzxw
        XO6EXBWPvuhd4ZbFou421BaHDV/Zubc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-vGw9FXxmNzutBgxQX_1oWA-1; Thu, 16 Jun 2022 09:00:29 -0400
X-MC-Unique: vGw9FXxmNzutBgxQX_1oWA-1
Received: by mail-qk1-f200.google.com with SMTP id y8-20020a05620a44c800b006a6f8cd53cbso1657187qkp.5
        for <linux-wpan@vger.kernel.org>; Thu, 16 Jun 2022 06:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e8ZVUkV5slpBiU5gnP3i9vX4TyyFnQAAf/ZHvzAvayg=;
        b=qKLbwMTLRYp+evHHl7MBHTlOlgzV8QraYyS5IhIC9aqdEjMrNQkXKG+/pc+4aQPSNZ
         Tm9YuxNsHAehyb9OP9BOPCu+R5xK4CFGRI1NdiNO1SmeWz/HQXVnjPjiTJhJxgrDp2Gk
         J+H3MJWY02+sJw+iuxfjJsvwmbWGkoKC052jlV0eLqnUB8lO2eFR0cPVnT2/TcLuUHGo
         YdMa68DLi2Leuq+l/OKp4+86EuIEHeDfHAByIa+seas1VV/i5xXqn5tQZh7Y69o0RUCe
         fHJRUM8gthEwrxlw4RAPdjf8RJS9y39YJHfGAkCuMrBHI4qeiOJ+Zk3Uove2j6ki01k3
         6MJg==
X-Gm-Message-State: AJIora9OosA6iHlXjPenxeQylOEz2hksO/Zqyl9uGb+nsiGx7xWFbCJF
        /mPFDyhPy6pawsQE4LVr7tyMKzE+2iGkzy2N/OIzV5aH2dUGa+aGoX7IatKN6VMyWm7oIDNJ1Ur
        ploJjC5sk+nULq7a2MsqH3MbjsmblG053tSIncw==
X-Received: by 2002:ac8:5dd2:0:b0:304:ea09:4688 with SMTP id e18-20020ac85dd2000000b00304ea094688mr3843308qtx.526.1655384419697;
        Thu, 16 Jun 2022 06:00:19 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s8NkXax/fhJn4p4KB+vrjzTc8SwiO52rQs1d5sXZGTBSfZ9nwuhdYltnFR7y17gdFUY49O0yt9bUAY4fI7De8=
X-Received: by 2002:ac8:5dd2:0:b0:304:ea09:4688 with SMTP id
 e18-20020ac85dd2000000b00304ea094688mr3843279qtx.526.1655384419441; Thu, 16
 Jun 2022 06:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAK-6q+g1jy-Q911SWTGVV1nw8GAbEAVYSAKqss54+8ehPw9RDA@mail.gmail.com>
 <e3efe652-eb22-4a3f-a121-be858fe2696b@datenfreihafen.org>
In-Reply-To: <e3efe652-eb22-4a3f-a121-be858fe2696b@datenfreihafen.org>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Thu, 16 Jun 2022 09:00:08 -0400
Message-ID: <CAK-6q+h7497czku9rf9E4E=up5k5gm_NT0agPU2bUZr4ADKioQ@mail.gmail.com>
Subject: Re: 6lowpan netlink
To:     Stefan Schmidt <stefan@datenfreihafen.org>
Cc:     linux-wpan - ML <linux-wpan@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Thu, Jun 16, 2022 at 3:57 AM Stefan Schmidt
<stefan@datenfreihafen.org> wrote:
>
> Hello Alex.
>
> On 13.06.22 05:44, Alexander Aring wrote:
> > Hi all,
> >
> > I want to spread around that I started to work on some overdue
> > implementation, a netlink 6lowpan configuration interface, because
> > rtnetlink is not enough... it's for configuring very specific 6lowpan
> > device settings.
>
> Great, looking forward to it!

I would like to trigger a discussion about rtnetlink or generic. I can
put a nested rtnetlink for some device specific settings but then the
whole iproute2 (as it's currently is) would maintain a specific
6lowpan setting which maybe the user never wants...
I think we should follow this way when there is a strict ipv6 device
specific setting e.g. l2 neighbor information in ipv6 ndisc.

- Alex

