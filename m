Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359C426ADD
	for <linux-wpan@vger.kernel.org>; Tue, 10 Sep 2024 00:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725927543; cv=none; b=NLm73mebmbCXOTLWbt1w/tV22FBxzVokDwH892FjZP69YYQP04tk4nLmEQ/5ttvAdiYxzVdJVW/Wc1AKpLT2E078YZ5FHqiXtucZxfCVrW+wK1YpkfTtG0uiv+z/KX5gHvIQ5BIN4y8OZPJUos7C+LfOZyUhoo7lBctAk2PVTQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725927543; c=relaxed/simple;
	bh=w/TQF68u2qmGAh1xhf2aHSizCqtdxfVAJ0mUDRUim0Q=;
	h=Content-Type:From:Mime-Version:Subject:Message-Id:Date:To; b=Kap5zCpcPi8puK4f9C/XXJJC/uZKxY20Vjbs6w4c2IC5BHFS1zzoJdQn97qFakRMXR/kWGlMDDmhGM4B+AGHgm+eNze2etygKdbuK4QttGFbDiirUjoQ59yLsNYmUHBxYf4VfkxVIQClOrFkhOHKbVatZ6uj1B6Qu6G0m1I4lBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dgtlrift.com; spf=fail smtp.mailfrom=dgtlrift.com; dkim=pass (2048-bit key) header.d=dgtlrift-com.20230601.gappssmtp.com header.i=@dgtlrift-com.20230601.gappssmtp.com header.b=1PYVe4BK; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dgtlrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=dgtlrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dgtlrift-com.20230601.gappssmtp.com header.i=@dgtlrift-com.20230601.gappssmtp.com header.b="1PYVe4BK"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6d9f0cf5ae3so1287547b3.0
        for <linux-wpan@vger.kernel.org>; Mon, 09 Sep 2024 17:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dgtlrift-com.20230601.gappssmtp.com; s=20230601; t=1725927539; x=1726532339; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xx9on44Fm/cvwboB6EGImE7MIoPLrxc0oB01AzB2hGw=;
        b=1PYVe4BKxxw4WItt+3v0zfSTw/ROYrwy8fyZenbG4awZo4lAXq2iM4WOulultnZC18
         SUJhwHxHn0RVQV0+PW+buQ+SsVaKo1sbHS5qXthH/Njao4J63RkGNsx5c7pzPA6XYI+w
         d5NaLdxR1yKLhmid3k4Min1ga7YZUHzxdxyng6hIGxP1DFiR3NyxXbXk9asbrGTJyD2B
         x5VeN9KUlUhE+8IeCUEO8kzAvnTsnotSKlgJmE1jqnKCBhzAolta1HAjLRP34/aDkAEl
         QrgsGECPsZetEEhrEoiCi1koa1q9ELcLwoaFKleYtbA6S+r6k1PDpUfrL2mCjFzREOrF
         rLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725927539; x=1726532339;
        h=to:date:message-id:subject:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xx9on44Fm/cvwboB6EGImE7MIoPLrxc0oB01AzB2hGw=;
        b=hExseTVeEABCIzXgCpoqUWRL9SCCd11n+dqOy/WRspZNm34fEOWjdSJcIB261mZU9v
         LjsfC9l/D4KyuO5Y0G8+HCUmBq4oPWjkh/nzI0X3CuRcticn46foN8FKc+Oyl9CEWOb+
         neXDIi2eyj3TJEMh6rs8C+GHJWbgfwcnOqhgzLMDc0doyIEB1EeYmLmfJU4Lpze9HyaD
         KwGbIUv/pIyECKmYAWQnfRVVujiIXuyKSxfK/+rkQNSgWGdRJG79rCo+MOd6HYOc5nsM
         pXtpinhCjKl7qth99+dswrkkZdRrCzyeYkCbctbDdClw0YPPmWEKZ/L0sC3BMJ15mXew
         psVg==
X-Gm-Message-State: AOJu0YxhxrwYynzKGLhHi6AMZ++nr2p2ayHyYNxPPdIYo28ZAPet+XCX
	Ojcypx9cYzD4uMoK2zqPWhkofeBNsNjCM0afkpQYpzFuj7nW+Tih4Rdw8Prmhd+DqJzkrG6XMLo
	=
X-Google-Smtp-Source: AGHT+IHajxwraosHjyMT9myukmbJTeroN4xARB1taJ+XFCoDFIFIQQn1hYPMAaY1B4e6iMs9B0KHLQ==
X-Received: by 2002:a05:690c:ec6:b0:643:4879:3399 with SMTP id 00721157ae682-6db44d62bfemr126213847b3.6.1725927538655;
        Mon, 09 Sep 2024 17:18:58 -0700 (PDT)
Received: from smtpclient.apple ([2600:1005:b009:1c8e:8062:8393:eec6:4676])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6db965217efsm1195987b3.122.2024.09.09.17.18.57
        for <linux-wpan@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 17:18:58 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From: James Hanley <jhanley@dgtlrift.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: 802.15.4-2020 PHR field changes
Message-Id: <A99422D6-46AE-42D1-852D-85D3EC3AFD53@dgtlrift.com>
Date: Mon, 9 Sep 2024 20:18:47 -0400
To: linux-wpan@vger.kernel.org
X-Mailer: iPhone Mail (21G93)

Has there been any effort to understand the changes needed to include/net/ie=
ee802154.h and associated files within drivers/net/ieee802154 to support the=
 ratification of 15.4-2020?  One prime example is the "Extended PHR" bit whi=
ch was previously reserved to now allow extend the PHR of 2 more octets givi=
ng bits 8-11 to be used for "Frame Length MSB" and bits 12-15 marked as "Res=
erved" - this in combination of the legacy PHR bits 0-6 labeled as "Frame Le=
ngth LSB" now allows for a frame MTU of 2048 octets.

The 802.15.4-2020 is available individually free of charge through the IEEE w=
ebsite through the IEEE Get Program. https://ieeexplore.ieee.org/document/91=
44691=20

Is there a way to prototype these new changes to the spec with the mac802154=
_hwsim driver?

 -Jim
