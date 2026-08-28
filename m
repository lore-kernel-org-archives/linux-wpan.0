Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463CE200110
	for <linux-wpan@vger.kernel.org>; Fri, 28 Aug 2026 05:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787896135; cv=pass; b=hBsBXb774pgh61aZKLlUH4cMZPR0MTZ6cwsbvAjlXbvq69jbziNqEVBIZbDEpM9RcfixFqm0sEoh1bHKKgixkciC2gz7s/zVUGT8IVsYyk3J4bQLIXDlkmRkohZiLbL5HFyXcctTAhtOoiLGensWknvcoB9XqeKK3f1pWR0F/iA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787896135; c=relaxed/simple;
	bh=QZcZIYCT+Re7sKM4Gb3CgS7BkE6WBbGG4LvAQn5P0Gc=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=ABM7dXxJ7pjVFFklot8INiRc5b50svmMbLzrkHRBsPWJtTTFmCg+cguc6KqMIx9xbDj7mZPsH7gM53po0ocwFBiLfTe6vfm4rn7F+mcTwm31JHqZHWgSSbEdNYPa+S18gh0ZIuhcXPCnPXQwcrZPnIxXYKnChB16JdideDzOaaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=KtLvys0e; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="KtLvys0e"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc1b838f9b6so770204a12.3
        for <linux-wpan@vger.kernel.org>; Thu, 27 Aug 2026 22:48:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787896133; cv=none;
        d=google.com; s=arc-20260327;
        b=JSwh8M06xYJ3LZjCtGsBe9oR+aAZhQka3g3XP9Ckq5QsIf9tfoN1e9hcrAuANP/UkY
         kjarXZVbPpIrkmldAcBb1SA6Xm/dkTxGGqSLYkENJjmM+8IYXrRGMkodf7Krx1JqQa9X
         CyM9FC+ZuagIbTVOgE4UkFBobBnCCapJ/e8AeLlKM3LrIVgM2CQtKgSSDzW2yYJx1NzN
         JCJU+YFvlU56tTAdjfdJDKiQqJFMYsnplm96kSEaaIkJfZemEPWbHf1DgBWZ6IQOeVSa
         b//E1YnEf+G6V3X0rRSzlwqUO6tzzzUaDWS8jlSE6R8NmgmUQurIgdAyZkmI6lMM3m9m
         f0VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=XGiqvAKih07txWqwNMygIXFEXpvBV7V29xEbvP7fW4M=;
        fh=YCu5AnrwMuJ2OOfTDO0KKlDKkLBYlzMA3ItwE0gAsGU=;
        b=cIbMX5GYaNMJDXsITDIdGtRfaAHpvLRC0wmCSsPKs2+wXQ+lOZYF3BwNl2i07AcVWm
         RtDicQ3+OrJ/N17pSBIVf7CGC5LLYaPNUIsJSmAowpt+oMs1fhvPk5D8PJIWi5ktJ+HC
         79eiB9rUnowJ+KUv76O7bBhfAwXz+tz6L8MZRSJove2kS8YbERzg925yVHB+QyAIbMix
         OiaXskM904YkQN2ofbO0hxAyYGmnMcyadizmebsh7m/mdLwglmOyFQ59GIU18IKcfRth
         nmPWn595bmrpNI4sAyXo/TsWEb58RGRdYMk6cx4lmB0iPgHK8qGPE50cEAfOmQgxr2+H
         JHWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1787896133; x=1788500933; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XGiqvAKih07txWqwNMygIXFEXpvBV7V29xEbvP7fW4M=;
        b=KtLvys0erzE5TMYNiHelAvjCRsWGATW9zco+Y0shnzgT6SjmMJiv31Ke5+wXXB6/QM
         mRqp/In9MlxcKNKDAbJ+BGih87/8p/iXqLlK3qHm2FNX/Ham/glsyPzVX9DYH9DZABsC
         csY5CUjA4QBhsAtWtZlw1w5DUzi/L3UrMYDwNuwFn+i1bh3l0wObOl8FfIirQCqFO3R/
         4knWVfj3FBftRcjLA7jMklqXF5cRjauwN9H7rVERcyvLT5jAA5TWpmKXsty44pxQP/a+
         9ShJc+XZIBLtRkY65qP8TKUIw+zPKiW3Z/XCVqe5vdOwJrnXLJwdLeiQ2EOUXW6D4KdV
         pHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787896133; x=1788500933;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XGiqvAKih07txWqwNMygIXFEXpvBV7V29xEbvP7fW4M=;
        b=dffOVkcHqoKaCEKWEuovH25Sq2VR9HF99j7mqxyvgm4G2FPGWtefCBjZh/ElxuSAfc
         ebM4l2M+pKBxHnBXUSyvufT4tvdTKh4WVso66IaO51Fm115Tx33KIa0BhTRH110sYNNJ
         2/7iaZc9natx7+v6lzyBGgK4j9pFHuAsgVCjdTW+YlA7KC1lsru9f1taIKc543rMtGzH
         StdCJ4F1NH5fkPWQZaFnynRDY/F/tb/Mgj0rCLeSLPi+P5hsaQXhEDaGvMcV7A3TJ3mI
         Ae3nRSFVbQtLIyy3fIm4ghlH7GpKXqKMiFPzNBcjsULYzhLyF7cuXqaOXjTvlQFUcQC/
         umYA==
X-Forwarded-Encrypted: i=1; AHgh+Rr5dHYoWR+Wi3mNZPAQIc9gqexYwO6NQ0lbDQWP/czaybe1d2yCUzEap6vsWhPFttjw315qH4hFZdsK@vger.kernel.org
X-Gm-Message-State: AFuF++m9L2BqZJAaCOYeR9CmxYCTyUSaWKrHwIfzPfl7RTPHo6ouwizH
	TCLDSryRCdVgsCZKZD7NEru/m97/fhTZsdFaz1PVRwF2Igz01zM06DqHkpYdnvQta+oWkQZj+hV
	4vfuaelLyt8iacDWooooDGBPUf9BhViSZiUVHiktX
X-Gm-Gg: AR+sD109dtEUxFQ4LgM914kTP7onL4h8SRpg6fTGbCaJFlFkl/qQCHoupgt9YS24naJ
	DPBmLqyMBqOHhWdRYUz0WWcCZ+h5CoFo5M8j4oWPACliYU9NuKqVhjTjaGRHRymujDUpOX/x2++
	1b13gDAfN2yLfM1E9343Hpd/Wmd2+furnx2wO/A4eUml9Ypoo6NlkbXdGS8Yjss9HJkff3wLO04
	yuCMnMnCtiWxjNesf/SRppmqAOzzN+jvIbeL+N2/QhAFoXx10ljDBor8LIFMs5SFySmKWgkust6
	exJ6DIVTwl2q/qqlHUI7ZcagF1mUIakqDVk2nrAFMYtiSMNy4cYjNB8rQYAHfCpo2IHL18uX18x
	9BmLUR8wiO6Qic+v5ZCYTlIFCEUJArQ+GSQ==
X-Received: by 2002:a17:90b:1d04:b0:38e:4cb:51f with SMTP id
 98e67ed59e1d1-396d0f75f2fmr9434380a91.11.1787896132569; Thu, 27 Aug 2026
 22:48:52 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 28 Aug 2026 05:48:52 +0000
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 28 Aug 2026 05:48:52 +0000
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 28 Aug 2026 05:48:52 +0000
X-Gm-Features: AcwNN1VegKfxy6tXl_M334rwOdANRXO1AtXiatObd5RyLQjD6NlT09EXgv8WeTo
Message-ID: <CA+0ovChS18paCd=ZE-7j_M-JtFF-N6+A75deKUqJ0Yy7ux=h2Q@mail.gmail.com>
Subject: [BUG] WARNING in lowpan_compress_addr_64
To: Alexander Aring <alex.aring@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: falemi@asu.edu, linux-bluetooth@vger.kernel.org, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

As part of the kernel research at ASU's SEFCOM
lab, we hit the crash below. Crash reports can be found here:

  https://github.com/farhad-alemi/public_bug_reports/tree/main/182-warning-in-lowpan-compress-addr-64/

  WARNING: net/6lowpan/iphc.c:937 at
lowpan_iphc_compress_802154_lladdr net/6lowpan/iphc.c:937 [inline],
CPU#0: syz.9.76/13660
  WARNING: net/6lowpan/iphc.c:937 at
lowpan_compress_addr_64+0x4be/0x9c0 net/6lowpan/iphc.c:952, CPU#0:
syz.9.76/13660
  RIP: 0010:lowpan_compress_addr_64+0x4be/0x9c0 net/6lowpan/iphc.c:952
  Call Trace:
   lowpan_compress_addr_64+0x4be/0x9c0 net/6lowpan/iphc.c:952
   lowpan_header_compress+0xeef/0x1ef0 net/6lowpan/iphc.c:1242
   lowpan_header net/ieee802154/6lowpan/tx.c:234 [inline]
   lowpan_xmit+0x4c6/0x1420 net/ieee802154/6lowpan/tx.c:282
   dev_hard_start_xmit+0x23b/0x620 net/core/dev.c:3904
   __dev_queue_xmit+0x11e7/0x3250 net/core/dev.c:4870
   packet_snd net/packet/af_packet.c:3082 [inline]
   packet_sendmsg+0x3d9b/0x5150 net/packet/af_packet.c:3114
  Kernel panic - not syncing: kernel: panic_on_warn set ...

Our reproducer.c is available upon request.

Happy to test a patch if that would help.

Regards,
