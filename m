Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3171922F8
	for <linux-wpan@vger.kernel.org>; Thu, 12 Sep 2024 23:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726182017; cv=none; b=lvnUK+oN8riej2E773CEmDDnxIFoNs0trokp+Niv+DocTf+d980UOSdnW3R06AX/RfiIodLkX720oSWOrJ28u17O+g8fqDrSWJiDdMD4SzuDNEt4QCJzQ/XpXazf7NoXLiIKQkw55h9/1789CVaFyzwKc9WsxGZliWPDzmPiP8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726182017; c=relaxed/simple;
	bh=xk8MxkOQtufVj8euvuvD2hPnB2WxEkK16xFeH3eaZ4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KlnYroEUNDk5x8R9qQVfMQh29qmvWgA38zqDw7s55OJgEuF+wMwHiRqPbgnaAP4yxVEaxmdRH7b5bbfkQI5WQ5vB/rfSAdBaCA9uCxo8CewHPZ7sLP4b+6kY9mQ019g1oToznWrWLpA0pXDz00Hbx0nzBXdfIcQCQajptFikhcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gv7bl6wp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gv7bl6wp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726182014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gM+fMCvo/fjKIPrxz3u5YMeMjKnuKJdBrb+4Cy58SAY=;
	b=gv7bl6wpvXSM6Y9HrG95BN1EIiO54q48WPMSMjrastEX705c8IjKhC/LNwzWDJVs5qEs9N
	O0jGtaN0erld7kNpKc2SkuWmocO8DavYopimjXcmkNbZc198gJje4MQ00A5GEAgpSf3zYs
	UyD2ZBfXxsReXRXqvyTixgGiVma4EUk=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-H0YwFxYjNi-kOwa89iqRAQ-1; Thu, 12 Sep 2024 19:00:13 -0400
X-MC-Unique: H0YwFxYjNi-kOwa89iqRAQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2f753de91b8so14021101fa.1
        for <linux-wpan@vger.kernel.org>; Thu, 12 Sep 2024 16:00:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726182011; x=1726786811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gM+fMCvo/fjKIPrxz3u5YMeMjKnuKJdBrb+4Cy58SAY=;
        b=OXXdibBbDMU2li3O4qSOJ2eKptIiZ3Tz8eC9C+bmtfKkUp88baNRwoYHUXk9PvNuRY
         vAWk3XikTUgAQtOsIvSGRQEGh65lWZotzBuuFtOYM08KqAOyXS9elj++kiUYAXBdqz1k
         SGu3HyOhmvB0eI9UgXytr4MKrbQv7tfGsHfGUCYD3hF2aRrrjjsMg7dWfMN3Y+j680gZ
         J78+cv/L3zjyewe1PPw+mSqwIvQAbGBc7VskzukXTuaIMDJQNiWtfRjX8tdpuT9V3CgR
         9sXgEKuxYc47kF039R90RQ5V8NJY/TkGGagomsr7KaR+KNMk/Hk+1eQ1tSYyxnFQXr9U
         byug==
X-Gm-Message-State: AOJu0Ywu1ATuMZgXFbQz7nTzBJ2j/0RTe0Iqcab6GVvGlc51KDFqWFfp
	vi8iRL0GmH2b8JN/Drg0PwhPFDmU2SPyH7jS8PmrgYZpjIgMrZmcnifG0rtMeIXiQICHVcCTKvS
	JcV8unO1VrfL6bhpIjfOf/slXJ2FfHjG3UrC/GqMhi60912l0pYqPYznPKiUrACVkfheOgo7swH
	etsnnvCWA7cpddpw+tC1nBPHyQukTNKVYOqcg8MwO5A+Km
X-Received: by 2002:a2e:a587:0:b0:2f6:5f0a:9cfe with SMTP id 38308e7fff4ca-2f787f1c6femr27252621fa.30.1726182011273;
        Thu, 12 Sep 2024 16:00:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/4lUzQa56eN1s1IYMmST0+dD2q0lSAdVooTlRfZhioEgb9V8j3KVsPwntRw5kfRPYk4c5+QG0oLeEmnJ9WGg=
X-Received: by 2002:a2e:a587:0:b0:2f6:5f0a:9cfe with SMTP id
 38308e7fff4ca-2f787f1c6femr27252481fa.30.1726182010682; Thu, 12 Sep 2024
 16:00:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <A99422D6-46AE-42D1-852D-85D3EC3AFD53@dgtlrift.com>
In-Reply-To: <A99422D6-46AE-42D1-852D-85D3EC3AFD53@dgtlrift.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Thu, 12 Sep 2024 18:59:59 -0400
Message-ID: <CAK-6q+jqJ=xaLH_G08hU0qNVXqoeqaA+_u20s4H+aiqt_70sFg@mail.gmail.com>
Subject: Re: 802.15.4-2020 PHR field changes
To: James Hanley <jhanley@dgtlrift.com>
Cc: linux-wpan@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 9, 2024 at 8:19=E2=80=AFPM James Hanley <jhanley@dgtlrift.com> =
wrote:
>
> Has there been any effort to understand the changes needed to include/net=
/ieee802154.h and associated files within drivers/net/ieee802154 to support=
 the ratification of 15.4-2020?  One prime example is the "Extended PHR" bi=
t which was previously reserved to now allow extend the PHR of 2 more octet=
s giving bits 8-11 to be used for "Frame Length MSB" and bits 12-15 marked =
as "Reserved" - this in combination of the legacy PHR bits 0-6 labeled as "=
Frame Length LSB" now allows for a frame MTU of 2048 octets.
>
> The 802.15.4-2020 is available individually free of charge through the IE=
EE website through the IEEE Get Program. https://ieeexplore.ieee.org/docume=
nt/9144691
>
> Is there a way to prototype these new changes to the spec with the mac802=
154_hwsim driver?
>

mac802154_hwsim driver uses mac802154 the SoftMAC implementation.
There are quite more changes necessary as the whole mac802154 stack
deals with static 127 bytes MTU defines, etc. Unfortunately, it isn't
just a driver change.

- Alex

