Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8ADAE92FCB
	for <linux-wpan@archiver.kernel.org>; Thu,  5 Oct 2023 22:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjJEWL3 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 5 Oct 2023 18:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjJEWL2 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 5 Oct 2023 18:11:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8CBE4
        for <linux-wpan@vger.kernel.org>; Thu,  5 Oct 2023 15:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696543841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6aHMrxnKFRL8eZP2ZR9DPlVMl+BHWqD42jAitaZoUq8=;
        b=JrI/W0ru/uUR5od3wmiGIbdWb52RCYcYDB37k1Vcl490zOzq2tVPAFzlkhoRPElpZ5Tg/x
        mvH9ImPXMKatJCkgUaMrAncneD1flToICHlZiPVwRn/VBDLXXJXnarRNhpT8ji9u/BeoZr
        9dJVM2c2kKRAy7W1GNPWWUchXImbdSs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-ojfDY2AePTa5URKxgIaKBw-1; Thu, 05 Oct 2023 18:10:25 -0400
X-MC-Unique: ojfDY2AePTa5URKxgIaKBw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5346626c1c5so1190481a12.1
        for <linux-wpan@vger.kernel.org>; Thu, 05 Oct 2023 15:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696543824; x=1697148624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6aHMrxnKFRL8eZP2ZR9DPlVMl+BHWqD42jAitaZoUq8=;
        b=lBeMWiIHr/sfkxJZcrN2pvjxzIPrjHppYNmGtXajoVv2l1dsRM+H96R57Smf7UKqFR
         CwUqZscREXOgBLaxfk0KKs8OAfD766OdS3Z8VZ1qAT1M8L/0aEU4wsZReaDzdcUq7dSy
         xUuJbhvY4NBqLxAzzbjXWuIrxSZOCWnuThZnRcIKR7xhAd6o/rcA0Y7I/Fy6j4m5t2KD
         RoWSxKGRNJ3xSqFNCiVrGxGKjnlTzohnLRiU5LlIV0CKUovOzHzGuaA/O2MQwbMUdpfT
         wX50AVXZ0aqD1RIk1OHdZAe7b0Xl6YhQlew877NYtxZV0+wc/DkfqMGKdenPAEKR+qYT
         p94Q==
X-Gm-Message-State: AOJu0YwA0iGuumfrwA4JqQnoo17QiE+hs0j44xNs6SVmrxwgM1yI7Cv1
        DdeErvcv4+S55uWCTR+j0qfykTZGjmJMfPm7vH10kTCQOcvrDGT32yRGNIeWTm2QW1XnQNSlw+l
        f2JlYn7xj5VNa3M7YJWqF1XlNSMYy4Y70J8rFXg==
X-Received: by 2002:aa7:d615:0:b0:52b:db31:3c48 with SMTP id c21-20020aa7d615000000b0052bdb313c48mr5783975edr.0.1696543824461;
        Thu, 05 Oct 2023 15:10:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpNdCbvG6JhfAS3lwMZiyvboAoUGjRJHfOGjkHcza1InSbT5oi3sklaEIketz0hkFWheMaLuZomkliQzgw6to=
X-Received: by 2002:aa7:d615:0:b0:52b:db31:3c48 with SMTP id
 c21-20020aa7d615000000b0052bdb313c48mr5783968edr.0.1696543824238; Thu, 05 Oct
 2023 15:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <3c91e145-5cd5-4d9d-9590-3b74b811436a@moroto.mountain>
In-Reply-To: <3c91e145-5cd5-4d9d-9590-3b74b811436a@moroto.mountain>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Thu, 5 Oct 2023 18:10:13 -0400
Message-ID: <CAK-6q+iG=jX0qudCcszP64HxCwYSpmx7=Fh+Kf3qVft7Z8hBfg@mail.gmail.com>
Subject: Re: [PATCH net] 6lowpan: fix double free in lowpan_frag_rcv()
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Angus Chen <angus.chen@jaguarmicro.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Joel Granados <joel.granados@gmail.com>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Wed, Oct 4, 2023 at 5:22=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
>
> The skb() is freed by the caller in lowpan_invoke_rx_handlers() so this
> free is a double free.
>

lowpan_frag_rcv() does not call lowpan_invoke_rx_handlers(), it calls
lowpan_invoke_frag_rx_handlers(), or is there something I overlooked
here?

- Alex

