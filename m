Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35741 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732086AbeLTQAh (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 20 Dec 2018 11:00:37 -0500
Received: by mail-ot1-f68.google.com with SMTP id 81so2369752otj.2
        for <linux-wpan@vger.kernel.org>; Thu, 20 Dec 2018 08:00:37 -0800 (PST)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com. [209.85.167.180])
        by smtp.gmail.com with ESMTPSA id k13sm20631183otj.19.2018.12.20.08.00.35
        for <linux-wpan@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 08:00:35 -0800 (PST)
Received: by mail-oi1-f180.google.com with SMTP id y23so2267335oia.4
        for <linux-wpan@vger.kernel.org>; Thu, 20 Dec 2018 08:00:35 -0800 (PST)
MIME-Version: 1.0
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
 <20181216101858.9585-6-starnight@g.ncu.edu.tw> <20181217140233.GG2096@nanopsycho>
 <CAC=mGziN5KrXPMAXoN_hhfQrtofCeyzTr4AjbbJLOoJ+p2+Nng@mail.gmail.com>
 <60ff6940-4bcc-750c-ad38-0a183375169f@suse.de> <BY1PR02MB11148DBF420DCAC7CCDD8A79E7BE0@BY1PR02MB1114.namprd02.prod.outlook.com>
 <CAC=mGzg4TGCaNUbq=_kFqmF5VNFR6rWHVBwO_5Fprt0u3m1O9g@mail.gmail.com> <CAJuUDwuYnuOs=7bs4h77XufqXLSWnZHVocR7vPYA1eor2HG+Cg@mail.gmail.com>
In-Reply-To: <CAJuUDwuYnuOs=7bs4h77XufqXLSWnZHVocR7vPYA1eor2HG+Cg@mail.gmail.com>
From: Jian-Hong Pan <starnight@g.ncu.edu.tw>
Date: Fri, 21 Dec 2018 00:00:41 +0800
Message-ID: <CAC=mGzgk0uSZRzE5NJ=FrLwaAkT3yYLb5j-0oFpouZ0YKFhtWQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] net: maclorawan: Implement maclorawan class module
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Xue Liu <liuxuenetmail@gmail.com>
Cc: Ben Whitten <Ben.Whitten@lairdtech.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, "linux-lpwan@lists.infradead.org" <linux-lpwan@lists.infradead.org>, Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>, linux-wpan - ML <linux-wpan@vger.kernel.org>

>  Hello Pan,
>
> where can I find your current source code for these patches. I would
> like to add netlink support based on them and at the same time to make
> a user tool.

I am developing the patches based on Andreas' LoRa repository [1]
You can apply the patches upon the "lora-next" branch.

I also wrote some testing programs.  But they are dirty now.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-lora.git/log/?h=lora-next

Regards,
Jian-Hong Pan
