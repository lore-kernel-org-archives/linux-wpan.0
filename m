Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F8317C4
	for <linux-wpan@vger.kernel.org>; Thu, 23 Nov 2023 02:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aQ+aYWZh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A074FC433C7;
	Thu, 23 Nov 2023 02:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700707334;
	bh=rRbIXqjq8DKBA6vW+7glleky65j8TQodsqrm6IeWtY0=;
	h=Date:From:To:Subject:From;
	b=aQ+aYWZhTEc0P8fVZzuyh5cPbGTGp3IqAsAhAJHPTTTUEp2cYIBrYNt83rd4iDIST
	 SbaRwVsgMifu2xuYFddTtBHqXXOhtch+T0KB8iXEATV4+//90cQo2EJ/CCdhpMrwJS
	 +N9HOF5rdrUEhIXNG6Tz4YZ4jGrwhBh7/zsbbSL0=
Date: Wed, 22 Nov 2023 21:42:13 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: linux-wpan@vger.kernel.org
Subject: PSA: this list has moved to new vger infra (no action required)
Message-ID: <20231122-prudent-ferret-of-action-5af9df@nitro>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello, all:

This list has been migrated to the new vger infrastructure. No action is
required on your part and there should be no change in how you interact with
this list.

This message acts as a verification test that the archives are properly
updating.

If something isn't working or looking right, please reach out to
helpdesk@kernel.org.

Best regards,
-K
