<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SapuJerr</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #D30015; /* Brand Red */
            height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', sans-serif;
            overflow: hidden;
        }
        
        .splash-logo {
            font-size: 4rem;
            font-weight: 800;
            font-style: italic;
            color: white;
            letter-spacing: -3px;
            margin-bottom: 40px; /* Increased space for the car */
            animation: pulseLogo 2s infinite;
        }

        /* --- CAR LOADER CSS --- */
        .road-container {
            position: relative;
            width: 300px;
            height: 4px;
            background-color: rgba(0, 0, 0, 0.2); /* Dark track */
            border-radius: 4px;
            margin-bottom: 20px;
        }

        .progress-bar {
            height: 100%;
            width: 0%; /* Starts at 0 */
            background-color: white;
            border-radius: 4px;
            position: relative;
            transition: width 0.5s ease-in-out; /* Smooth movement */
        }

        .car-wrapper {
            position: absolute;
            right: 0; /* Stick to the right edge of the white bar */
            top: -14px; /* Position above the line */
            transform: translateX(50%); /* Center car on the tip */
            color: white;
            font-size: 24px;
            /* Engine rumble animation */
            animation: rumble 0.2s infinite alternate; 
        }

        .loading-text {
            margin-top: 10px;
            color: rgba(255, 255, 255, 0.9);
            font-size: 1.1rem;
            font-weight: 500;
            min-height: 24px;
            text-align: center;
            letter-spacing: 0.5px;
        }

        @keyframes pulseLogo {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }

        @keyframes rumble {
            from { margin-top: 0px; }
            to { margin-top: -2px; }
        }
    </style>
</head>
<body>
    <div class="splash-logo">SapuJerr</div>
    
    <div class="road-container">
        <div class="progress-bar" id="progressBar">
            <div class="car-wrapper">
                <i class="fa-solid fa-car-side"></i>
            </div>
        </div>
    </div>
    
    <div class="loading-text" id="statusText">Initializing...</div>

    <script>
        const loadSteps = [
            "Connecting to secure server...",
            "Verifying Student ID...",
            "Loading local maps...",
            "Syncing driver availability...",
            "Preparing dashboard..."
        ];

        const statusElement = document.getElementById('statusText');
        const progressBar = document.getElementById('progressBar');
        let stepIndex = 0;

        // Function to cycle through messages and move car
        const loadInterval = setInterval(() => {
            if (stepIndex < loadSteps.length) {
                // Update text
                statusElement.innerText = loadSteps[stepIndex];
                
                // Calculate percentage (stepIndex + 1 because we want to move forward immediately)
                const percentage = ((stepIndex + 1) / loadSteps.length) * 100;
                progressBar.style.width = percentage + "%";
                
                stepIndex++;
            } else {
                // Finished
                clearInterval(loadInterval);
                setTimeout(() => {
                    window.location.replace('LoginServlet');
                }, 500); // Small delay to let the car finish the animation
            }
        }, 600); 
    </script>
</body>
</html>