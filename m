Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C6AC6FA99
	for <linux-wpan@archiver.kernel.org>; Tue,  7 Mar 2023 23:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjCGXbE (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 7 Mar 2023 18:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCGXbD (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Mar 2023 18:31:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE133A8C6B
        for <linux-wpan@vger.kernel.org>; Tue,  7 Mar 2023 15:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678231807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J6PI1+iCyE6roSMv9xD9czxTetp5xB/wELaV59zECsA=;
        b=UeqgWKznONFz3xjSZ5pOv1pxSYLnUK39MAPTNWsi4Z4GmB65ys1rndX1/pd8LJVE8MBVkj
        5B3PuLBZ/dpvfO/TZjz1ymgWVhLrqJzf0mBr1yB8ToGGWmyyFhrH4DOISWAm0Z/L0Y9vu0
        siLtUifLVgo7luvCZemQ+mWQ7n9sfZM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-QJLnQ36IOXGJ2mse-yTwNg-1; Tue, 07 Mar 2023 18:30:05 -0500
X-MC-Unique: QJLnQ36IOXGJ2mse-yTwNg-1
Received: by mail-ed1-f69.google.com with SMTP id y24-20020aa7ccd8000000b004be3955a42eso21350221edt.22
        for <linux-wpan@vger.kernel.org>; Tue, 07 Mar 2023 15:30:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678231804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6PI1+iCyE6roSMv9xD9czxTetp5xB/wELaV59zECsA=;
        b=bjDe/jNxO41SLxnVfVQl6zp6mlME1/GiRZbisOqTl7E6GjEPfjeQS/gY6m9fZ5eDTm
         uvH+WkN1C4P8nNNMVSflyrtjJkbmFa2pwn3XI5Nz2+TtWSUCbbMWY1pjN5StyKMgNkAv
         EezGVWZLnwPMgSQLHSzsOyGyq38oHVD3rjMbr2C4eC1pbpE3LBg/OzCCBXbZrSRsvJjB
         uB9LE8GZNF+oqku4JCSynDUzhi/Usn8Jrf+7KiOcELb7+3irjg6JFL7ZdlnOn9992d81
         SADU9lXvBXojDL+CbObVIht5QPfsXXX31e7d2GxrHIRviUFqZIJJzNpqWsTZSjoHXI6A
         gnaw==
X-Gm-Message-State: AO0yUKXjm2bEcCCv/uc1tc/BDnI+25yHa24DGD08RitYjjse0jI0ul4L
        /RIiE7/HbnqBjnEHFL5dABv0uVPA1YG+bR9HVOAg1kKxB4Yek/7McybHmVn06gyv6Io6n28zcwl
        3YzgLn/jGVOQTatfGv2tylPNPXB9y49ytNtg1cA==
X-Received: by 2002:a17:906:338e:b0:895:58be:963 with SMTP id v14-20020a170906338e00b0089558be0963mr8232076eja.3.1678231804501;
        Tue, 07 Mar 2023 15:30:04 -0800 (PST)
X-Google-Smtp-Source: AK7set9coWPUtSLheaorma3dgyMbSg7MoTxqNt3KtKyykwtN6bNRkYrNVGPELngFdSk7U65m5Hc5Z4Cg9GtbJewyOo8=
X-Received: by 2002:a17:906:338e:b0:895:58be:963 with SMTP id
 v14-20020a170906338e00b0089558be0963mr8232062eja.3.1678231804260; Tue, 07 Mar
 2023 15:30:04 -0800 (PST)
MIME-Version: 1.0
References: <20230306191824.4115839-1-harshit.m.mogalapalli@oracle.com> <ZAb5BlS+OgFfJM6t@corigine.com>
In-Reply-To: <ZAb5BlS+OgFfJM6t@corigine.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 7 Mar 2023 18:29:52 -0500
Message-ID: <CAK-6q+gH-GzRNArVzrkdmrZ20qzGwAXRwhuc8XP0tpdDg3tvXw@mail.gmail.com>
Subject: Re: [PATCH next] ca8210: Fix unsigned mac_len comparison with zero in ca8210_skb_tx()
To:     Simon Horman <simon.horman@corigine.com>
Cc:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Dan Carpenter <error27@gmail.com>,
        Alexander Aring <alex.aring@gmail.com>,
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

On Tue, Mar 7, 2023 at 3:44=E2=80=AFAM Simon Horman <simon.horman@corigine.=
com> wrote:
>
> On Mon, Mar 06, 2023 at 11:18:24AM -0800, Harshit Mogalapalli wrote:
> > mac_len is of type unsigned, which can never be less than zero.
> >
> >       mac_len =3D ieee802154_hdr_peek_addrs(skb, &header);
> >       if (mac_len < 0)
> >               return mac_len;
> >
> > Change this to type int as ieee802154_hdr_peek_addrs() can return negat=
ive
> > integers, this is found by static analysis with smatch.
> >
> > Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device drive=
r")
> > Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
>
> I discussed this briefly with Harshit offline.
>
> The commit referenced above tag does add the call to
> ieee802154_hdr_peek_addrs(), an there is a sign miss match between
> the return value and the variable.
>
> The code to check the mac_len was added more recently, by the following
> commit. However the fixes tag is probably fine as-is, because it's fixing
> error handling of a call made in that commit.
>
> 6c993779ea1d ("ca8210: fix mac_len negative array access")
>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
>

sure, thanks for catching this.

- Alex

