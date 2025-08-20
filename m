Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CAC2D6E47
	for <linux-wpan@vger.kernel.org>; Wed, 20 Aug 2025 20:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755722908; cv=none; b=nbXufvKn6YPD7vZVMcW5VDyPdwspKJ2InTaWKViclPTWilYZh1PTk81bxlZMF0Ao7vUciVF3POj3VcbLbShl8hyw1Hqn98LK+8BB6g+iKA8VeC3BJj+xfK+PLGsK+TQcOU5g+UgizV79p/90zlHohJ8NTUvi7jAUfTvrNFTYO04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755722908; c=relaxed/simple;
	bh=t5Tp46zvTFmc/AyR66IfCCMFgvbG8DCu85vo1X9yDKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=euC7XzsZ2RIZkCglIBHtR9p5FEFE/8nJqe+C6Kg8GzlapY3+MUM1oKqpC8HiCfqshYE+6O/MDd2ch9M6Kn8pm0Tbyikip2kq4HptPTyyMOd5WUGC5zGm6rwpM53drB0e/r8xabiBA1Nq5caiB+cph3Xw2hkqJgj9qrNLqXHnK1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b=sVN9nJ66; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="sVN9nJ66"
Received: from [192.168.2.30] (unknown [45.118.184.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 9F952C051A;
	Wed, 20 Aug 2025 22:42:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1755722564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c1pXXKXqBP8SI+L3EQPCzlUQ1WoToyW4Lgtswiokuvs=;
	b=sVN9nJ66ImvZajadCrTppvahRQTXxdIKDXyZ2THC9tcrHMKpgPO6539UU101shvhkfaKYe
	+Mflx8pJl1Ia+BSbbVk7b4PTO9SRJEFqaCzSVYlkYB4woKKw4SF2FPALxNW5LXFJqg8HP3
	opGs55+rLghDgnrv5Tc/DIPIszdUlxkMlC6UoZL7OVjnetRVNSfAp9zFqnisjyZWJpigVg
	oM4LTkbZu6xLyRttIk44erVOkbxBQx36kWcanKV3akQh1CMtHtxr6e2qapheEYIOnBFtgI
	bycaFwvIfmrLQXIenIJ+23GhUFGyk7RqjFBQExwNMPWG9aUenY3InyoOzV4Uew==
Message-ID: <9e127ed9-13e3-47c4-a287-154a6071b378@datenfreihafen.org>
Date: Wed, 20 Aug 2025 22:42:44 +0200
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] GSoC 2025 upstream wpanusb bcfserial
To: manas gupta <manasgupta3131@gmail.com>, linux-wpan@vger.kernel.org
References: <CAJ9b4C22ZM9RKMDo+1U9gdK8e4iewKaz8vdO7xjmKytJ1fjrRg@mail.gmail.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Content-Language: en-US
In-Reply-To: <CAJ9b4C22ZM9RKMDo+1U9gdK8e4iewKaz8vdO7xjmKytJ1fjrRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Manas,

On 04.08.25 04:48, manas gupta wrote:
> hi all,
> 
> I'm Manas, a GSoC 2025 contributor @BeagleBoard org working on the
> project upstream wpanusb bcferial as part of my efforts I am aiming to
> upstream these drivers to simplify on-going support.
> 
> I'm writing to this list to introduce the project, share the progress
> made so far, and respectfully ask for your guidance on the best path
> forward for upstreaming the drivers.
> 
> The drivers have had multiple functional gaps before they can be
> upstreamed, over the past few weeks I have been working on quite a few
> of them.
> 
> To address the first major gap, I have spent the initial phase of the
> project implementing the missing driver operations. The driver now has
> functional implementations for:
> set_txpower(), set_lbt(), set_cca_mode(), set_cca_ed_level(),
> set_csma_params(), set_frame_retries(), set_promiscuous_mode(),


Good so you filled up some of the gaps for driver ops.

> Enhanced parameter validation per IEEE 802.15.4 standard, Improved
> error handling and debug logging and worked on the zephyr application.
> Currently I am working on generic aspects which are hardcoded and
> Dynamic device capabilities.

Here you refer to the part where the Zephyr application would query the 
the hardware and set bands, channels, power levels, etc dynamically from 
the radio API of Zephyr? This should really be generic. It should work 
with any 15.4 transceiver supported by Zephyr, and expose the right 
capabilities for the hardware.

>> Stefan's notes mentioned heavy work on management frames and scanning. Are there any new driver ops or architectural changes on the horizon that I should be aware of and plan for in this driver?

Not at the moment. Scanning, beaconing, etc has landed and the latest 
wpan-tools release has support for it as well.
> 
> I am eager to contribute and follow the best practices of the kernel
> community. Any feedback on the work so far, patch submission
> strategies and guidance would be incredibly valuable.

A first start would be to get all the pieces together that are involved, 
e.g. zephyr wpanusb application, bfcserial, wpanusb linux driver and 
describe how they are supposed to work together. Having a clear 
description on this would actually help us to give you feedback if that 
is a good way forward.

> Based on community feedback, I plan to:
>    1. Address any architectural concerns raised
>    2. Implement suggested improvements
>    3. Prepare formal patch series for submission

This part is something you should start as early as possible. As Alex 
mentioned you can just have the series send out as RFC. No harm in 
showing us your working prototypes to get feedback. The doc how it fits 
together and how to test it would be part of your series cover-letter.

>    4. Coordinate hardware testing with BeagleConnect devices
>    5. Document any remaining limitations
> 
> I would greatly appreciate any guidance on:
>    - Code review and architectural feedback
>    - Upstreaming process and requirements

Please read up on submitting patches on the Linux kernel. There is 
plenty of docs for this, no need to repeat all of it.

This could be a start: 
https://docs.kernel.org/process/submitting-patches.html

I would encourage you to use b4 for handling your patch series. If you 
are familiar with teh kernel development process plain git can also 
work, but b4 is taking some problems off your plate.

>    - Testing strategies and requirements

You should always amke sure that your prototype works on your setup. 
(mention the setup in your cover-letter). I would assume for you that 
might be two BeagleConnect Freedom boards. Running tests with creating a 
PAN, scanning, joining, raw 15.4 frames transfer as well as 6lowpan 
communication would be the tests we are looking for.

Once we reached a state where we are happy with the driver code I can 
also give it a go.

> 
> Thank you for your time and consideration. I look forward to contributing to
> the Linux IEEE 802.15.4 subsystem.
> 
> project forum link:
> https://forum.beagleboard.org/t/upstream-wpanusb-and-bcfserial/37186
> 
> gsoc page- https://summerofcode.withgoogle.com/programs/2025/projects/xZofecH8
> org repo link: https://openbeagle.org/beagleconnect/linux
> 
> my repo links
> wpanusb driver: https://github.com/manas-gupta-3131/bb-gsoc-wpanusb
> bcfserial driver: https://github.com/manas-gupta-3131/bb-gsoc-bcfserial

This one is empty.

> wpanusb_bc(zephyr application):
> https://github.com/manas-gupta-3131/bb-gsoc-wpanusb_bc

regards
Stefan Schmidt
